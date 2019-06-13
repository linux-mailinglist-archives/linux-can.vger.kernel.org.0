Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED32C44CFF
	for <lists+linux-can@lfdr.de>; Thu, 13 Jun 2019 22:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbfFMUHx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 13 Jun 2019 16:07:53 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:27400 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfFMUHw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 13 Jun 2019 16:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1560456467;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=rDaAVq+8qRIIDvovlIkTfT3voIlBQrHpf34wCSgaB4I=;
        b=laioWrRt+j4gnSnBRlIaXYt7r76QnC3e7Tyc9hcUJbm195F7oMbrfGr8RZ1yzBSlfW
        KNfRQS5onY2aTEFOxKtfZ/IlbIZndz5I6MW0Ts/dd9Ex2KJF9jO9ac0Nd2UmJsAYPnqq
        s7dZVe6NmtNZ+c/ntRSwIXf3VJH7Cqoo8MIY1/EU0aAQb5zX76jdfrNiiSbnyoabOsAh
        0G+OsCSt4JhxL2Dil4uhxE4DTM2Bca1P4ogkTagJ2EhVuta42zecfmzGKvs+Chryo55J
        OFJzLNNlKyVQjz9Ph1iB4fQipvaMIbatZ5eC4RVs5TzwbKS8XDhtpIKLZlQa+bypLsNm
        nKtQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1q3jadVqEJzoOTmrZ/ds="
X-RZG-CLASS-ID: mo00
Received: from [10.255.43.86]
        by smtp.strato.de (RZmta 44.23 DYNA|AUTH)
        with ESMTPSA id n00890v5DK7330S
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 13 Jun 2019 22:07:03 +0200 (CEST)
Subject: Re: [PATCH] CAN: correct history of the CAN protocol
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de
References: <alpine.LFD.2.21.1906121147020.8460@localhost.localdomain>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <fc38c9f3-23f6-6076-3cdf-76773ef05443@hartkopp.net>
Date:   Thu, 13 Jun 2019 22:06:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1906121147020.8460@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 12.06.19 17:48, Robert P. J. Day wrote:
> 
> Current history of CAN protocol is wrong, fix it in the Kconfig file.
> 
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks Robert!

> 
> ---
> 
> diff --git a/net/can/Kconfig b/net/can/Kconfig
> index 0f9fe846ddef..d4319aa3e1b1 100644
> --- a/net/can/Kconfig
> +++ b/net/can/Kconfig
> @@ -8,11 +8,12 @@ menuconfig CAN
>   	tristate "CAN bus subsystem support"
>   	---help---
>   	  Controller Area Network (CAN) is a slow (up to 1Mbit/s) serial
> -	  communications protocol which was developed by Bosch in
> -	  1991, mainly for automotive, but now widely used in marine
> -	  (NMEA2000), industrial, and medical applications.
> -	  More information on the CAN network protocol family PF_CAN
> -	  is contained in <Documentation/networking/can.rst>.
> +	  communications protocol. Development of the CAN bus started in
> +	  1983 at Robert Bosch GmbH, and the protocol was officially
> +	  released in 1986. The CAN bus was originally mainly for automotive,
> +	  but is now widely used in marine (NMEA2000), industrial, and medical
> +	  applications. More information on the CAN network protocol family
> +	  PF_CAN is contained in <Documentation/networking/can.rst>.
> 
>   	  If you want CAN support you should say Y here and also to the
>   	  specific driver for your controller(s) below.
> 
