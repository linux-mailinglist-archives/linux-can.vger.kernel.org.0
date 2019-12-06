Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7255C1150F7
	for <lists+linux-can@lfdr.de>; Fri,  6 Dec 2019 14:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfLFNX4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Dec 2019 08:23:56 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48300 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfLFNX4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Dec 2019 08:23:56 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB6DNmpZ015081;
        Fri, 6 Dec 2019 07:23:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575638628;
        bh=+v4tLUI02nl8GKLcVnPVCnQRXBMS+aaqszEyWL/Pcb4=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=QDeM7eqsH32Omc2tOa5sI5vP0aNqgx8+MPPoU0mGes/RNZSloLOsc8QFVIB2g3Yb0
         mY97WzZjtyvPCy//FiBVShc35E9LYwquIc2f3cjPKooSGnFMQ7ZzO1/oxPB5b4Q6ca
         i+7hsuMv8/7BKMC0ogc+ugCFfF0NVlRpTCMx6id0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB6DNmkS011854
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Dec 2019 07:23:48 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 6 Dec
 2019 07:23:48 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 6 Dec 2019 07:23:48 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB6DNmZB114990;
        Fri, 6 Dec 2019 07:23:48 -0600
Subject: Re: tcan4x5x
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Sean Nyekjaer <sean@geanix.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <c16a87a4-5021-b25f-076c-18aa7b482baf@geanix.com>
 <354a10d7-f515-26af-e023-478c975bcb9a@geanix.com>
 <3c6ac0e8-afe3-c713-52df-aa45694a8702@pengutronix.de>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <fac95d97-c7b8-7ee2-94ae-51007b01aa24@ti.com>
Date:   Fri, 6 Dec 2019 07:21:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <3c6ac0e8-afe3-c713-52df-aa45694a8702@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Sean

On 12/6/19 6:52 AM, Marc Kleine-Budde wrote:
> On 12/6/19 1:50 PM, Sean Nyekjaer wrote:
>> A usleep_range(700, 1000); right after the reset pin is put low will fix
>> the non talking device "Unsupported version number:  0".
>>
>> But i still have this on first probe, gone on second:
>> tcan4x5x spi2.0 (unnamed net_device) (uninitialized):
>> Failed to init  module
> Please send a patch.
>
> Marc
>
Since you have tested the two wake pin GPIO patches can you give a 
Tested-by for each?

Dan

