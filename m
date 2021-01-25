Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B908E3023AA
	for <lists+linux-can@lfdr.de>; Mon, 25 Jan 2021 11:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbhAYKaY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jan 2021 05:30:24 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:30444 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbhAYK2q (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jan 2021 05:28:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1611570328;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:From:
        Subject:Sender;
        bh=X+F5eBx6hhPWWwcF9ubIsqkxUL4WeBCjYPW2wcv2gyg=;
        b=AttGrlJZHfyEEHMUGXDD5n5Xbp74VGf3KBnt65aX6mZwLxhHMHffh3cXAW975uQ16f
        CO7XZafwQ4a8CcRLDM1yK+eFFnnccImERKPg6/Acgn6dgFpzZY5ZySuewUUtVCTKgdFN
        kwjvq+G5mUTGIydaaW27jVVk9Wr2jSQ33aYbcK3aGUwOvU+9JSKHUK1Mm+vToVLJq4kj
        6d08aIg7Ui5pKo4TIV4vwgrEE7ARNpM4o5rV+0nFXbmNEufQGvD0LdOO1VjxKzYhuqFG
        S1DwgOzhLl+S+AzKgtmHRBC48+s1MJziF0ou5stPsiM7lhn6nbx2TvyBXKmLOGuWq53c
        l2CA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR/J8xty10="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.12.1 DYNA|AUTH)
        with ESMTPSA id k075acx0PAPPxPs
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 25 Jan 2021 11:25:25 +0100 (CET)
Subject: Re: [PATCH v3 7/7] can: Update contact details
To:     Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
References: <20210120143723.26483-1-rpalethorpe@suse.com>
 <20210120143723.26483-8-rpalethorpe@suse.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <e39c4ae6-94df-9162-7357-d125ced72d17@hartkopp.net>
Date:   Mon, 25 Jan 2021 11:25:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210120143723.26483-8-rpalethorpe@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 20.01.21 15:37, Richard Palethorpe wrote:
> socketcan-users appears to be no more.
> 
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>

Thanks for the cleanup and the rework, Richard!

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
(for the entire series)

Best regards,
Oliver

> ---
>   testcases/network/can/filter-tests/00_Descriptions.txt | 5 +++--
>   testcases/network/can/filter-tests/Makefile            | 2 --
>   2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/network/can/filter-tests/00_Descriptions.txt b/testcases/network/can/filter-tests/00_Descriptions.txt
> index 55d213456..9623d29a0 100644
> --- a/testcases/network/can/filter-tests/00_Descriptions.txt
> +++ b/testcases/network/can/filter-tests/00_Descriptions.txt
> @@ -6,5 +6,6 @@ information on the CAN network protocol family PF_CAN is contained in
>   
>   For any issue(s) with CAN tests please write to:
>   <ltp@lists.linux.it>
> -<socketcan-users@lists.berlios.de>,
> -Oliver Hartkopp <oliver.hartkopp@volkswagen.de>,
> +Oliver Hartkopp <socketcan@hartkopp.net>
> +Linux-CAN ML <linux-can@vger.kernel.org>
> +
> diff --git a/testcases/network/can/filter-tests/Makefile b/testcases/network/can/filter-tests/Makefile
> index 29aaa3240..bd57c7fff 100644
> --- a/testcases/network/can/filter-tests/Makefile
> +++ b/testcases/network/can/filter-tests/Makefile
> @@ -14,8 +14,6 @@
>   #    You should have received a copy of the GNU General Public License along
>   #    with this program; if not, write to the Free Software Foundation, Inc.,
>   #    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> -#
> -#  Send feedback to <socketcan-users@lists.berlios.de>
>   
>   top_srcdir		?= ../../../..
>   
> 
