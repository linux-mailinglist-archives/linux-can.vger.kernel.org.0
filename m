Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94E3472D54
	for <lists+linux-can@lfdr.de>; Mon, 13 Dec 2021 14:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbhLMNb3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 13 Dec 2021 08:31:29 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23]:35886 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbhLMNb3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 13 Dec 2021 08:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1639402287;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=uWYWffHlY07rdmfRqqXTnmgq0O7q14FnKmkFPBHVEvg=;
    b=GaZplIBR9uVlCpjuLoKTZ+Z5Qkr3QVSJEMrnKkNclbzA0zB/F2vXKqVrPKHwst7plm
    RpUL8PJTmOajTU9nrs2+n2x8qopxW8wAzcXbnXeyY+x8twUvO+cwn5euLmebUZKO/KK7
    55FgMZssrB+pDYugvZcPu7v99RITtI4q3OhClnrf/NbPp1MuIrG6s4Wj62Lxr/iFPZRD
    LdhiQK3GtzA0aYxfVy/TgrY3+guPaV1FsNFguHXOogY2sE+jqjSFM8gBswwoMTz865df
    B5tVvOQ4sA4zLTcaqNoFPn5f0OSul2rx2tcW0SGAw1M47PpKLqtF7Gn3WfSAEGiA2XtE
    lcRA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdd0DIgVuBOfXW6v7w=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a00:6020:1cfa:f900::b82]
    by smtp.strato.de (RZmta 47.35.3 AUTH)
    with ESMTPSA id u01c23xBDDVQCPU
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 13 Dec 2021 14:31:26 +0100 (CET)
Subject: Re: [PATCH] can: gs_usb: detach device on reception of invalid USB
 data
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Peter Fink <pfink@christ-es.de>
References: <20211210091158.408326-1-mkl@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <17be229c-eac4-2bee-bc05-484123c99823@hartkopp.net>
Date:   Mon, 13 Dec 2021 14:31:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211210091158.408326-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 10.12.21 10:11, Marc Kleine-Budde wrote:
> The received data contains the channel the received data is associated
> with. If the channel number if bigger than the actual number of
                               ^^

I always have to remind myself to take out the chewing gum before 
dictating commit messages  :-D

Best,
Oliver

> channels assume broken or malicious USB device and shut it down.
> 
> This fixes the error found by clang:
> 
> | drivers/net/can/usb/gs_usb.c:386:6: error: variable 'dev' is used
> |                                     uninitialized whenever 'if' condition is true
> |         if (hf->channel >= GS_MAX_INTF)
> |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
> | drivers/net/can/usb/gs_usb.c:474:10: note: uninitialized use occurs here
> |                           hf, dev->gs_hf_size, gs_usb_receive_bulk_callback,
> |                               ^~~
> 
> Cc: Peter Fink <pfink@christ-es.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>   drivers/net/can/usb/gs_usb.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index f8316a26ee35..d33ba13643af 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -384,7 +384,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
>   
>   	/* device reports out of range channel id */
>   	if (hf->channel >= GS_MAX_INTF)
> -		goto resubmit_urb;
> +		goto device_detach;
>   
>   	dev = usbcan->canch[hf->channel];
>   
> @@ -478,6 +478,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
>   
>   	/* USB failure take down all interfaces */
>   	if (rc == -ENODEV) {
> + device_detach:
>   		for (rc = 0; rc < GS_MAX_INTF; rc++) {
>   			if (usbcan->canch[rc])
>   				netif_device_detach(usbcan->canch[rc]->netdev);
> 
