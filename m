Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9D10CF4D2
	for <lists+linux-can@lfdr.de>; Tue,  8 Oct 2019 10:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbfJHISW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 8 Oct 2019 04:18:22 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:41998 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730384AbfJHISW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 8 Oct 2019 04:18:22 -0400
X-ASG-Debug-ID: 1570522699-0a7b8d13bfcafe0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.105.74.adsl.dyn.edpnet.net [77.109.105.74]) by relay-b02.edpnet.be with ESMTP id rdZ4bvpIj0tmqoN8 for <linux-can@vger.kernel.org>; Tue, 08 Oct 2019 10:18:19 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.105.74.adsl.dyn.edpnet.net[77.109.105.74]
X-Barracuda-Apparent-Source-IP: 77.109.105.74
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id D6A64A47259
        for <linux-can@vger.kernel.org>; Tue,  8 Oct 2019 10:18:18 +0200 (CEST)
Date:   Tue, 8 Oct 2019 10:18:15 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Subject: Re: [PATCH] can-rx-offload: free echo_skb when not queued
Message-ID: <20191008081815.GB20524@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [PATCH] can-rx-offload: free echo_skb when not queued
Mail-Followup-To: linux-can@vger.kernel.org
References: <1570001287-32420-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1570001287-32420-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.105.74.adsl.dyn.edpnet.net[77.109.105.74]
X-Barracuda-Start-Time: 1570522699
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 859
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5678 1.0000 0.7500
X-Barracuda-Spam-Score: 3.85
X-Barracuda-Spam-Status: No, SCORE=3.85 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=BSF_SC0_MV0249, MARKETING_SUBJECT
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.77210
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.60 MARKETING_SUBJECT      Subject contains popular marketing words
        2.50 BSF_SC0_MV0249         Custom rule MV0249
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Ping
Marc,

Did you look over this one.
I had it in a seperate thread as it covers an isolated thing.

> Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> ---
>  drivers/net/can/rx-offload.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.c
> index e6a668e..a8acb2a 100644
> --- a/drivers/net/can/rx-offload.c
> +++ b/drivers/net/can/rx-offload.c
> @@ -238,6 +238,7 @@ unsigned int can_rx_offload_get_echo_skb(struct can_rx_offload *offload,
>  
>  	err = can_rx_offload_queue_sorted(offload, skb, timestamp);
>  	if (err) {
> +		kfree_skb(skb);

Am I right that the skb would have been lost in case the queue reached
it max length and you're dropping messages?

>  		stats->rx_errors++;
>  		stats->tx_fifo_errors++;
>  	}
> -- 
> 1.8.5.rc3
> 
