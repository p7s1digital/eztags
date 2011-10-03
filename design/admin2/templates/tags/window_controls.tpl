{def $tag_exists = is_set( $tag )}

{if $tag_exists}
    {def $tag_url                 = concat( 'tags/id/', $tag.id )
         $tab_index               = first_set( $view_parameters.tab, 'general' )
         $valid_tabs              = array( 'general', 'latest', 'synonyms', 'limits', 'search' )
         $read_open_tab_by_cookie = true()
    }
{else}
    {def $tag_url                 = 'tags/dashboard'
         $tab_index               = first_set( $view_parameters.tab, 'latest' )
         $valid_tabs              = array( 'latest', 'search' )
         $read_open_tab_by_cookie = true()
    }
{/if}

{if $valid_tabs|contains( $tab_index )|not()}
    {set $tab_index = cond( $tag_exists, 'general', 'latest' )}
{elseif is_set( $view_parameters.tab )}
    {set $read_open_tab_by_cookie = false()}
{/if}

<ul class="tabs{if $read_open_tab_by_cookie} tabs-by-cookie{/if}">
    {if $tag_exists}
        <li id="node-tab-tags-general" class="first{if $tab_index|eq('general')} selected{/if}">
            <a href={concat( $tag_url, '/(tab)/general' )|ezurl}>{'General'|i18n( 'extension/eztags/tags/view' )}</a>
        </li>
    {/if}

    <li id="node-tab-tags-latest" class="{if $tag_exists}middle{else}first{/if}{if $tab_index|eq('latest')} selected{/if}">
        <a href={concat( $tag_url, '/(tab)/latest' )|ezurl}>{'Latest tags'|i18n( 'extension/eztags/tags/dashboard' )}</a>
    </li>

    {if and( $tag_exists, $tag.main_tag_id|eq( 0 ) )}
        <li id="node-tab-tags-synonyms" class="middle{if $tab_index|eq('synonyms')} selected{/if}">
            <a href={concat( $tag_url, '/(tab)/synonyms' )|ezurl}>{'Synonyms'|i18n( 'extension/eztags/tags/view' )}</a>
        </li>

        <li id="node-tab-tags-limits" class="middle{if $tab_index|eq('limits')} selected{/if}">
            <a href={concat( $tag_url, '/(tab)/limits' )|ezurl}>{'Subtree limitations'|i18n( 'extension/eztags/tags/view' )}</a>
        </li>
    {/if}

    <li id="node-tab-tags-search" class="last{if $tab_index|eq('search')} selected{/if}">
        <a href={concat( $tag_url, '/(tab)/search' )|ezurl}>{'Tags search'|i18n( 'extension/eztags/tags/search' )}</a>
    </li>
</ul>
<div class="float-break"></div>

<div class="tabs-content">
    {include uri='design:tags/windows.tpl'}
</div>

{ezscript_require( 'node_tabs.js' )}
{undef}