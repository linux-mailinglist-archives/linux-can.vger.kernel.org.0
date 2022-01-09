Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCF5488BE7
	for <lists+linux-can@lfdr.de>; Sun,  9 Jan 2022 20:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbiAITGk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 9 Jan 2022 14:06:40 -0500
Received: from relay-b02.edpnet.be ([212.71.1.222]:46180 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiAITGk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 9 Jan 2022 14:06:40 -0500
X-Greylist: delayed 1188 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Jan 2022 14:06:40 EST
X-ASG-Debug-ID: 1641754009-15c433197229ae3d0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (94.105.123.152.dyn.edpnet.net [94.105.123.152]) by relay-b02.edpnet.be with ESMTP id jG2rPYXUwxK6EDZU; Sun, 09 Jan 2022 19:46:49 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 94.105.123.152.dyn.edpnet.net[94.105.123.152]
X-Barracuda-Apparent-Source-IP: 94.105.123.152
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 994A01778F89;
        Sun,  9 Jan 2022 19:46:49 +0100 (CET)
Date:   Sun, 9 Jan 2022 19:46:48 +0100
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH] can: softing: softing_startstop(): fix set but not used
 variable warning
Message-ID: <YdstmL4KSn70ziqx@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [PATCH] can: softing: softing_startstop(): fix set but not used
 variable warning
Mail-Followup-To: Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org
References: <20220109103126.1872833-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220109103126.1872833-1-mkl@pengutronix.de>
X-Barracuda-Connect: 94.105.123.152.dyn.edpnet.net[94.105.123.152]
X-Barracuda-Start-Time: 1641754009
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 2235
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.95216
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Acked-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

> out. Its stated that the functionality is not finally verified.

The subsequent call works, but I wasn't able to produce the bus errors,
so I could not verify that is actually worked.

And by now, I don't have access to the card, nor do I have a PCMCIA slot :-)

Kurt

On zo, 09 jan 2022 11:31:26 +0100, Marc Kleine-Budde wrote:
> In the function softing_startstop() the variable error_reporting is
> assigned but not used. The code that uses this variable is commented
> out. Its stated that the functionality is not finally verified.
> 
> To fix the warning:
> 
> | drivers/net/can/softing/softing_fw.c:424:9: error: variable 'error_reporting' set but not used [-Werror,-Wunused-but-set-variable]
> |         int j, error_reporting;
> 
> remove the comment, activate the code, but add a "0 &&" to the if
> expression and rely on the optimizer rather than the preprocessor to
> remove the code.
> 
> Fixes: 03fd3cf5a179 ("can: add driver for Softing card")
> Cc: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/softing/softing_fw.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/can/softing/softing_fw.c b/drivers/net/can/softing/softing_fw.c
> index 7e1536877993..32286f861a19 100644
> --- a/drivers/net/can/softing/softing_fw.c
> +++ b/drivers/net/can/softing/softing_fw.c
> @@ -565,18 +565,19 @@ int softing_startstop(struct net_device *dev, int up)
>  		if (ret < 0)
>  			goto failed;
>  	}
> -	/* enable_error_frame */
> -	/*
> +
> +	/* enable_error_frame
> +	 *
>  	 * Error reporting is switched off at the moment since
>  	 * the receiving of them is not yet 100% verified
>  	 * This should be enabled sooner or later
> -	 *
> -	if (error_reporting) {
> +	 */
> +	if (0 && error_reporting) {
>  		ret = softing_fct_cmd(card, 51, "enable_error_frame");
>  		if (ret < 0)
>  			goto failed;
>  	}
> -	*/
> +
>  	/* initialize interface */
>  	iowrite16(1, &card->dpram[DPRAM_FCT_PARAM + 2]);
>  	iowrite16(1, &card->dpram[DPRAM_FCT_PARAM + 4]);
> -- 
> 2.34.1
> 
> 
