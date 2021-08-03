Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4471B3DEDF3
	for <lists+linux-can@lfdr.de>; Tue,  3 Aug 2021 14:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbhHCMhw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 3 Aug 2021 08:37:52 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23]:11111 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbhHCMhw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 3 Aug 2021 08:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1627994256;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=i8qw8GnXo3lH3fnYgzex796igd3y3xsMePLqd1rjo9Y=;
    b=OZuPGEGBH6kJa/b+ZJ1n+wjG+/bF5v89MIHjsEo+tkkrV6V6Kjpxx+5SGKaTtcyr09
    wbTJDhY+CGhcWaFB1/S+MF6j7pdg9qLMQobjZl2/Xb+ee8FsGNDHfXXNI6sehj+Ukj6+
    VYUwgqwSdNqEUtyjXKG+vYUCWOViSDjYuDKDPwPVjUBrit6jouOgCV5aeEfZ158FDl6x
    eX9aDafSqZXKjvYrXLwg6vcgt+ngG225gEun20EGRShoEUSqpk49LdGdwTdMHVzIkmuw
    PpMYsK17Vka+ZAAk2dmpyU3YAyCxI63A8ziIO8tIXHz7xrQVGHe4r4lTj0iiAQvWPbCi
    T13Q==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSaVHfOnZpL4pXGcZUU3PtFyotFv9pQT1mXDddOnDGQ0lqHV7n"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:b98:4731:d170:f5a6:f8c6:2b42:2e18]
    by smtp.strato.de (RZmta 47.28.1 AUTH)
    with ESMTPSA id Z03199x73CbapLb
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 3 Aug 2021 14:37:36 +0200 (CEST)
Subject: Re: [PATCH v2] can: Documentation: Sending with canfd_frame on a CAN
 2.0 interface
To:     Thomas Wagner <thomas@the-wagner.de>, mkl@pengutronix.de
Cc:     linux-can@vger.kernel.org
References: <20210802102853.29308-1-thomas@the-wagner.de>
 <20210802104048.32007-1-thomas@the-wagner.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <b784563b-a489-8e3f-1152-7e3d4c948422@hartkopp.net>
Date:   Tue, 3 Aug 2021 14:37:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210802104048.32007-1-thomas@the-wagner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 02.08.21 12:40, Thomas Wagner wrote:
> In response to my uncertainty described here
> https://lore.kernel.org/linux-can/20210729121417.kysljj4636hmhem2@pengutronix.de/T/#t.
> 
> This patch clarifies sending CAN 2.0 frames on CAN FD capable hardware
> when the interface is configured as CAN 2.0.
> 
> Signed-off-by: Thomas Wagner <thomas@the-wagner.de>
> ---
>   Documentation/networking/can.rst | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
> index f34cb0e4460e..ac3fe948c888 100644
> --- a/Documentation/networking/can.rst
> +++ b/Documentation/networking/can.rst
> @@ -675,6 +675,17 @@ When sending to CAN devices make sure that the device is capable to handle
>   CAN FD frames by checking if the device maximum transfer unit is CANFD_MTU.
>   The CAN device MTU can be retrieved e.g. with a SIOCGIFMTU ioctl() syscall.
>   
> +You should also check the MTU in an environment, where the device is CAN
> +FD capable, but the interface might be configured for just CAN 2.0. In
> +this case the canfd_frame struct can still be used, but when writing to
> +the socket write CAN_MTU bytes at most to send a CAN 2.0 frame.

IMO this is still confusing. The point is that the struct can_frame and 
canfd_frame have a compatible layout (up to the length of struct 
can_frame) - and therefore you can use struct canfd_frame up to this 
length for most use-cases. But not for all! E.g. the handling of raw DLC 
values for Classical CAN.

> +
> +In conclusion, to handle devices with and without CAN FD and with
> +interfaces configured as CAN 2.0 or CAN FD:
> +- Set the CAN_RAW_FD_FRAMES flag and ignore the error on older kernels

This is done in candump.c to be able to *receive* any kind of CAN(FD) 
traffic.

IMO this is generally not a good advise to ignore the result in any 
case. Please take a look into cansend.c how it is handled there.

> +- Send and receive using the canfd_frame struct

IMO when you know what you are doing and you are handling CAN *and* 
CANFD frames you get behind this simplification on your own.

There are still good reasons to work with the struct can_frame, e.g. 
when you want to work with raw CAN dlc values.

> +- Check the bytes received to know, whether you got an CAN 2.0 or FD frame

... once you set the CAN_RAW_FD_FRAMES flag.

> +- Check the devices MTU to know, whether you can send CAN 2.0 or FD frames

Yes. An example for that is in cansend.c
But I wonder if such a use-case is relevant to a normal CAN application.
The programmer usually knows whether he wants to work with CAN or CAN FD 
frames. And when sending a CAN FD frame results into an error you can 
just drop an error message about "sending the CAN FD frame not possible".

Best regards,
Oliver

