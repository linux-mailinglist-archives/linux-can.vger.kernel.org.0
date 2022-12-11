Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19D264966B
	for <lists+linux-can@lfdr.de>; Sun, 11 Dec 2022 22:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiLKVJC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 11 Dec 2022 16:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiLKVJC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 11 Dec 2022 16:09:02 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED2AB850
        for <linux-can@vger.kernel.org>; Sun, 11 Dec 2022 13:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1670792937;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=aSpB4q5ZdLjCTplnRLGLZXorgUS+IzWHmMfFKGKlVTo=;
    b=AeVOfadhJWjB6NYFH8tvd4rFJQBME5rQEUiOc2qe4nz4tipuBsAOkSe8ceRO1VMPPT
    8B43RVESISIEPq2TiRpaVBXAV+uSQGVlAN2Xlyixy62cD4+4xjzscanYPthnr1ZbOKk2
    LYzBxXOZUs/RkP0w+EM+tVbn1wQCsfOlE5ihrm58iCaFHWGGqw25ATtc0e2/dqWVxl2b
    h31EoW7Vl/90szpWCiXOQbvnd+rAE+Av9TR/aGU20DwD8UgUwOCSfw1mFsTbEWnFjCA0
    70Cm2sHprwnSfY2uYULoLuqQKaz02R6MQQlbSaqXD9a4GcmQbsLsiiHDg7Ion01xgXd8
    aD0g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR5J8xpzl0="
X-RZG-CLASS-ID: mo00
Received: from [192.168.60.87]
    by smtp.strato.de (RZmta 48.2.1 DYNA|AUTH)
    with ESMTPSA id Dde783yBBL8vPDg
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 11 Dec 2022 22:08:57 +0100 (CET)
Message-ID: <6c2f26c0-c7e9-ad41-5db2-cdd940f7d6d5@hartkopp.net>
Date:   Sun, 11 Dec 2022 22:08:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] can: raw: add support for SO_MARK
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        kernel@pengutronix.de
References: <20221210113653.170346-1-mkl@pengutronix.de>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20221210113653.170346-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 10.12.22 12:36, Marc Kleine-Budde wrote:
> Add support for SO_MARK to the CAN_RAW protocol. This makes it
> possible to add traffic control filters based on the fwmark.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Nice idea!

Best regards,
Oliver

> ---
>   net/can/raw.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 3eb7d3e2b541..81071cdb0301 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -857,6 +857,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>   
>   	skb->dev = dev;
>   	skb->priority = sk->sk_priority;
> +	skb->mark = sk->sk_mark;
>   	skb->tstamp = sockc.transmit_time;
>   
>   	skb_setup_tx_timestamp(skb, sockc.tsflags);
