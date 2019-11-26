Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 008BC10A053
	for <lists+linux-can@lfdr.de>; Tue, 26 Nov 2019 15:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfKZOdX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Nov 2019 09:33:23 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39402 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbfKZOdX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Nov 2019 09:33:23 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAQEXFem049296;
        Tue, 26 Nov 2019 08:33:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574778795;
        bh=jzzMtxs2tFoCFxi+1iobho6bZ9Kwp84/UP9NHh53zJw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=doBRpFAsV3xERTYyuqFV0PDoYhX0cN0Eh+c/QUginSXspIZlYChqH7g1S1uNz3088
         UlVwrMiMej0BDKQIaM8wYoGErr+Awd8IOQyGuok6wyg5h3x50YdJJXusaKg83K2o9j
         zoTP775eRZTqdRmDxzNczXITGlXh3R2RkBYGRTls=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAQEXF3Q103153
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Nov 2019 08:33:15 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 26
 Nov 2019 08:33:15 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 26 Nov 2019 08:33:15 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAQEXFVN001007;
        Tue, 26 Nov 2019 08:33:15 -0600
Subject: Re: Devicetree for can tcan4x5x
To:     Sean Nyekjaer <sean@geanix.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <e5892c08-03a5-60a6-61e0-6b75e248e172@geanix.com>
 <eb7aaa46-3cc8-4ed3-adcf-aaa95c8dd197@ti.com>
 <80e8f758-e240-f1b4-f0e2-3a53b2f22b99@geanix.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <d95c2d97-991e-6ba3-6d4a-3ea42463abc9@ti.com>
Date:   Tue, 26 Nov 2019 08:31:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <80e8f758-e240-f1b4-f0e2-3a53b2f22b99@geanix.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Sean

On 11/26/19 8:12 AM, Sean Nyekjaer wrote:
>
>
> <snip>
> Hi Dan,
>
> Thanks for the reply :)
> I have the driver loading now, just with the SPI entry.
>
> Our HW guys have hardwired the WAKE pin to GND, I'm guessing that's a 
> perfectly valid scenario.
> I have a small patch that makes the WAKE pin optional.
>
> /Sean
>
>
>
>
Let me check with our HW guys here to see if that is acceptable.

If it is we will need to update the DT doc and the code.

Dan

