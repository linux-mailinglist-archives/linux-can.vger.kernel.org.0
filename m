Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B44EF639F3
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 19:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfGIRJ0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 13:09:26 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:12255 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfGIRJ0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 13:09:26 -0400
X-Greylist: delayed 355 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jul 2019 13:09:25 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1562692164;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=IVeSt0e1J8SvDVVbG9XREaY23+cMgr7W2CknZSyD+tY=;
        b=rHAgohP9U6ZjUKHvdg+JFpi2AtL8Wpmnxm/NId9Lop0DnA+v/a1E8jGyanNN3bPV+j
        K+K8e84PSe//7z+x+UyyY047xtvOTxm8cSFRKPl77+hFpSanP4j+7E23wM5CN8Ths7tM
        sLdEYATbod7oyYuDB2rwSabC8sA0wEvo9G0qsffGzpr0fStT7cRuEyCzOpTWWPNqnDOz
        newvsmr6qexRcSAp/1zrEoG2jTh0fujzlm7ctcHcHhQ+a/jogEboF9+2v1DtevVqHAts
        wdcqRZDAn4YD3PV4YD0aj8t1tW5vRfrD1FGZ2fh8RTlzOpOp6IloWZVAme54b3ImJbW/
        5rew==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMGXsh5kUrI"
X-RZG-CLASS-ID: mo00
Received: from [192.168.40.177]
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id k05d3bv69H3I25Z
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 9 Jul 2019 19:03:18 +0200 (CEST)
Subject: Re: [PATCH v1 13/34] j1939: socket: drop sanity check for ifindex
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     kernel@pengutronix.de, linux-can@vger.kernel.org,
        robin@protonic.nl, david@protonic.nl
References: <20190709085909.1413-1-o.rempel@pengutronix.de>
 <20190709085909.1413-13-o.rempel@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <a680d36b-0cbd-f5a6-e3fc-786b518a62bb@hartkopp.net>
Date:   Tue, 9 Jul 2019 19:03:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190709085909.1413-13-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Oleksij,

the topic said what this patch does - but there's no commit message that 
tells the reader why the check can be dropped.

And the removed comment in the patch leaves me even more lost ...

Regards,
Oliver

On 09/07/2019 10.58, Oleksij Rempel wrote:
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>   net/can/j1939/socket.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
> index 19e662574b5f..39df867cfe84 100644
> --- a/net/can/j1939/socket.c
> +++ b/net/can/j1939/socket.c
> @@ -272,14 +272,9 @@ static bool j1939_sk_recv_match_one(struct j1939_sock *jsk,
>   static void j1939_sk_recv_one(struct j1939_sock *jsk, struct sk_buff *oskb)
>   {
>   	const struct j1939_sk_buff_cb *oskcb = j1939_skb_to_cb(oskb);
> -	const struct can_skb_priv *oskb_prv = can_skb_prv(oskb);
>   	struct j1939_sk_buff_cb *skcb;
>   	struct sk_buff *skb;
>   
> -	if (jsk->ifindex != oskb_prv->ifindex)
> -		/* this socket does not take packets from this iface */
> -		return;
> -
>   	if (!j1939_sk_recv_match_one(jsk, oskcb))
>   		return;
>   
> 
