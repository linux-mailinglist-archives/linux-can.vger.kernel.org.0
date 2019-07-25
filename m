Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FADA7506A
	for <lists+linux-can@lfdr.de>; Thu, 25 Jul 2019 16:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404265AbfGYN72 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 25 Jul 2019 09:59:28 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:33190 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404211AbfGYN7Z (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 25 Jul 2019 09:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1564063164;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=ZUhWqC4IRUVPiuodanfcFj1Tzo3PQkCP3UHwsL1dpuU=;
        b=J5l129DHrS1n+6/NR5EoJzGws4UIP1Q1kGHY1GKG1teBGtdgZ62dZd2XmE4DR6UXlA
        WeDAVVxssfK9HzRu4gWuonYRbbVn6xshUXOiz3a8JvwZcNrPn0D93V4Vcg5zh/dQk0QW
        GikslYvnrZNOmaFf+rIB5DsI+Axl+ClR6TuYqYlnjcZrb+123KQOL4+Qa8p+F/ZRcZyH
        TlcARxejLxtWhwx3auPJb5NaG5hXF8eS9OKp3dBUM0M5/x/tzBSpqRu6Z5Cn0+KkkSwX
        UMXiBSdEDsNce+02iTFwJPb0vekuGSAKMZ1MKXJmesviCgBzlwYKeVvZj51/6M2EOhss
        KPsQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJUsh/lyA="
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.200]
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id k05d3bv6PDxMkwn
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 25 Jul 2019 15:59:22 +0200 (CEST)
Subject: Re: [PATCH 2/2] can: gw: add support for CAN FD frames
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20190723130003.17733-1-socketcan@hartkopp.net>
 <20190723130003.17733-2-socketcan@hartkopp.net>
 <3c5aabfc-10cf-51b1-e76e-08c5cce8b56f@pengutronix.de>
 <f0c82e62-0b97-68eb-2bcb-27c6e92a113c@hartkopp.net>
 <2f24fc11-8123-8384-bf1c-63ee71424d27@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <65c2946b-15d0-e6cb-a28e-d0b713b6a256@hartkopp.net>
Date:   Thu, 25 Jul 2019 15:59:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2f24fc11-8123-8384-bf1c-63ee71424d27@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 25.07.19 09:04, Marc Kleine-Budde wrote:
> On 7/24/19 8:07 PM, Oliver Hartkopp wrote:

>> If the CAN FD length was 12 before the modification and the modification
>> was to "set bit 0 in the length field" then you get 13.
> 
> ok
> 
>> But the length value of 13 is an illegal value for CAN FD length and can
>> not been sent by a CAN FD controller.
> 
> ok, but that doesn't matter, because all CAN-FD drivers must convert
> from struct canfd_frame::len to the dlc (== their register value)
> anyways using the can_len2dlc() function.
> 
>> Therefore we need a round-up to get the next valid CAN FD length value
>> (in our example it get's from 13 to 16).
> 
> I don't think this is needed, the user space might send such packets and
> the drivers have to deal with then anyways.

Ok, maybe pointing to the driver lead to a wrong discussion.

We manipulate the length info and end with a CAN FD frame which has a 
length which is unspecified in the CAN standard.

A valid CAN FD frame can not have a data length of 13.

So we fix this up after manipulation.

Neither the CAN controller nor the user reading from a socket should 
ever get an invalid CAN FD frame.

Regards,
Oliver
