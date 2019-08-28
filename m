Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6889FEF9
	for <lists+linux-can@lfdr.de>; Wed, 28 Aug 2019 11:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfH1J4g (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Aug 2019 05:56:36 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.21]:24098 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfH1J4f (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Aug 2019 05:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1566986191;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Z3d1rzjUY7sqmKT8YWZkuM5kuRbJzrJvk5RCuFMrhaY=;
        b=GmVbBvI7sNOQqB3gg8L3PkNtan69WXzA1Xdo5AWLrC8zOamQ7ihDuq3XPuaf1w7kGR
        d0zLF0AGFucBE/MnXKsZP9RA6m8DU49t2ERGys7yRLfwCwIG24FQvPFUg1dfSkHsVHmI
        up8B1DUh9v40ns1253ttLxI0p2u2wsqL3nv+Qxhr7yLnFTwlyPF6gwtxwW6nglUV062H
        0OUvLaVmSATETLFJUreITdmLMEfXPzAaNCM/mKJ5w1tj6OUMsPCdBdE0y/TmiS53wQ4L
        1RZ9Kr3kxIKrAefsfOPP1dFqebQEnIivqhl4JGKDQ/Iv6dcocUZa2A/x6uvdHK6TnrbK
        y8Gw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1q3jXdVqE32oRVrGn+26NxA=="
X-RZG-CLASS-ID: mo00
Received: from [10.180.33.14]
        by smtp.strato.de (RZmta 44.27.0 AUTH)
        with ESMTPSA id j0667fv7S9uU4mA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 28 Aug 2019 11:56:30 +0200 (CEST)
Subject: Re: [PATCH 00/21] Add support for the J1939 Protocol
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc:     kernel@pengutronix.de
References: <20190828065226.23604-1-mkl@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <a101ddf0-5150-dd48-e456-3571cfc7036b@hartkopp.net>
Date:   Wed, 28 Aug 2019 11:56:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828065226.23604-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

this series only refactores & prepares the PF_CAN infrastructure to add 
the J1939 support ;-)

Btw. I think I can find some time for a review on Friday.

Best,
Oliver

On 28/08/2019 08.52, Marc Kleine-Budde wrote:
> Hello,
> 
> this series add support for the J1939 protocol to the kernel.
> 
> SAE J1939 defines a higher layer protocol on CAN. It implements a more
> sophisticated addressing scheme and extends the maximum packet size above 8
> bytes. Several derived specifications exist, which differ from the original
> J1939 on the application level, like MilCAN A, NMEA2000 and especially
> ISO-11783 (ISOBUS). This last one specifies the so-called ETP (Extended
> Transport Protocol) which is has been included in this implementation. This
> results in a maximum packet size of ((2 ^ 24) - 1) * 7 bytes == 111 MiB.
> 
> Please test and give feedback.
> 
> regards,
> Marc
> 
> 
