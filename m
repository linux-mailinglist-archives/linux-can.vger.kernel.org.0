Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDFC485673
	for <lists+linux-can@lfdr.de>; Wed,  5 Jan 2022 17:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241830AbiAEQIS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 Jan 2022 11:08:18 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:41891 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241809AbiAEQIR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Jan 2022 11:08:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1641398894;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=wMOphNO2iCS4BVDTyUoxJzNBZE8Y0fpB03xFtA6ms6k=;
    b=Y1Dq574EZaVLqZC+n/BFGsXAknMnt7dmEFMslWCJrjc0ljuidPlrpdQGqIqexymMbH
    fRyFHt/Ob68Wfo1JmsEmX/tko42QAQeONvHybtoXWzxmJVVn6+QY8F1OKUo22iOGBiZh
    KZyxww3wUxTp8Ls0bBeQzUE/8FadZZ+731TLYnhfEyBkjpymooP2y5w63JzZ+hTOiUuX
    E2/eM2AJJX3Y44XpMTtdY1MM0WSu9pYjcNYxoB2kaLDnOOnXTlle6Igwb2WkcAvQOYPx
    tGA8PSjZIate/bhLiPrseUybTdo9CuDlog721vsdFAMNQ598CbO2aiA82wq1e8Saiwuk
    KiVA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdd0DIgVuBOfXW6v7w=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a00:6020:1cfa:f900::b82]
    by smtp.strato.de (RZmta 47.37.4 AUTH)
    with ESMTPSA id 42952fy05G8E0Tk
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 5 Jan 2022 17:08:14 +0100 (CET)
Subject: Re: [PATCH RFC] can: isotp: convert struct tpcon::{idx,len} to
 unsigned int
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     syzbot+4c63f36709a642f801c5@syzkaller.appspotmail.com
References: <20220105132429.1170627-1-mkl@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <95302dc5-3b44-dc0a-96d4-ab52584e9faa@hartkopp.net>
Date:   Wed, 5 Jan 2022 17:08:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220105132429.1170627-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 05.01.22 14:24, Marc Kleine-Budde wrote:
> In isotp_rcv_ff() 32 bit of data received over the network is assigned
> to struct tpcon::len. Later in that function the length is checked for
> the maximal supported length against MAX_MSG_LENGTH.
> 
> As struct tpcon::len is an "int" this check does not work, if the
> provided length overflows the "int".
> 
> Later on struct tpcon::idx is compared against struct tpcon::len.
> 
> To fix this problem this patch converts both struct tpcon::{idx,len}
> to unsigned int.
> 
> Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
> \# Cc: stable@vger.kernel.org
> Cc: Oliver Hartkopp <socketcan@hartkopp.net>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks Marc!

> Reported-by: syzbot+4c63f36709a642f801c5@syzkaller.appspotmail.com
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>   net/can/isotp.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index df6968b28bf4..02cbcb2ecf0d 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -119,8 +119,8 @@ enum {
>   };
>   
>   struct tpcon {
> -	int idx;
> -	int len;
> +	unsigned int idx;
> +	unsigned int len;
>   	u32 state;
>   	u8 bs;
>   	u8 sn;
> 
