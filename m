Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F014AAAA7
	for <lists+linux-can@lfdr.de>; Thu,  5 Sep 2019 20:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388425AbfIESLs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Sep 2019 14:11:48 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:25331 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731491AbfIESLs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Sep 2019 14:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1567707106;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=MuHgB2JwXFZL+Mp0Sn+gAKHP1R2o3NGRi35FJ1PM8sk=;
        b=SYrf2/FgnNCL5X0EYZcgJ5x1mRSAsKsRkIt9c/0ZqKlGERS5P6UqgpT2t24OdQI2Pm
        vZQB3Pv+0ulg6cc5MCOyMFw+KMA0oqo7NfRunpzoFS3t6YrQ4+vZrPGECUBu7oYJqA1i
        PHqfMk3G+6ukCuNUfnZ65yw+hGqF+cqqXJPSf5P1BjuPBqHKD59Yvq3+QWRMml9hOD87
        rGnPq89p/+1t/TmvZ39NMnvCzcjxOM0tRxfK5fdBEmpwxPLZFk5dySq3VWsWsepThyzR
        LWgIK9Pf1oa2Tzi1hUQt7uCSTrp3170DXqA4fKpnBLFoaf2XB1HxLV1pG33kbBprgKdI
        xHOQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJVch5mUsS"
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.177]
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id j0667fv85IBjYD9
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 5 Sep 2019 20:11:45 +0200 (CEST)
Subject: Re: pull-request: can-next 2019-09-04 j1939,pull-request: can-next
 2019-09-04 j1939
To:     mkl@pengutronix.de
Cc:     kernel@pengutronix.de, linux-can@vger.kernel.org,
        bst@pengutronix.de, ecathinds@gmail.com,
        dev.kurt@vandijck-laurijssen.be, maxime.jayat@mobile-devices.fr,
        robin@protonic.nl, ore@pengutronix.de, david@protonic.nl
References: <d56029d4-2d4c-3cb3-0e5b-e28866db87f1@pengutronix.de>
 <20190905.121813.2071644369326938083.davem@davemloft.net>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <c83d495c-1259-ee69-c6e9-638a5a05225e@hartkopp.net>
Date:   Thu, 5 Sep 2019 20:11:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905.121813.2071644369326938083.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hey Marc,

On 05/09/2019 12.18, David Miller wrote:
> From: Marc Kleine-Budde <mkl@pengutronix.de>
> Date: Wed, 4 Sep 2019 14:29:56 +0200
> 
>> this is a pull request for net-next/master consisting of 21 patches.
> 
> Pulled, thanks Marc.
> 

Great news! So you need to update your slides for ELCE 2019 ;-)

https://osseu19.sched.com/event/TLNC/introduction-to-the-j1939-kernel-stack-marc-kleine-budde-pengutronix

I will be there too - looking forward to meet you in person again.

Best,
Oliver
