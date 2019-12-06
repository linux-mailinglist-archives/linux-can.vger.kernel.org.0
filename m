Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 742AD1150BF
	for <lists+linux-can@lfdr.de>; Fri,  6 Dec 2019 14:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfLFNDY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Dec 2019 08:03:24 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:45118 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfLFNDY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Dec 2019 08:03:24 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB6D3ISA076395;
        Fri, 6 Dec 2019 07:03:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575637398;
        bh=pMO67o5EunVtPw0glSznfDYQcbOKVEcJ3rZmSNFDOeI=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=FDCxCND8+MJE9hsIuxCKeHQhpM4RkJdmmV2t6tnhJYJ9Pyum0GstyehzQ4jTdk6qg
         BfPvd8LYnVpnm1cfU52jrSs1gaFFQILC2V5mE229YSvumsdUaINDAnGldVmf0i0Z+j
         Gbyy+wg+WNkwPG+wMlYqMucPBEdt6ELjSZ5+kZzE=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB6D3IXX114949
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Dec 2019 07:03:18 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 6 Dec
 2019 07:03:17 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 6 Dec 2019 07:03:17 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB6D3HRs038624;
        Fri, 6 Dec 2019 07:03:17 -0600
Subject: Re: tcan4x5x
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Sean Nyekjaer <sean@geanix.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <c16a87a4-5021-b25f-076c-18aa7b482baf@geanix.com>
 <354a10d7-f515-26af-e023-478c975bcb9a@geanix.com>
 <3c6ac0e8-afe3-c713-52df-aa45694a8702@pengutronix.de>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <1f84e965-1ed3-4c1a-d014-c99f6c74620d@ti.com>
Date:   Fri, 6 Dec 2019 07:01:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <3c6ac0e8-afe3-c713-52df-aa45694a8702@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
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
I am wondering if you need to increase the timeout in the m_can.c when 
reading the CCCR register.

Right now it is at 10us.  That was working for me on my setup and for 
MMIO devices but may be needed to be longer for faster processors.

Dan

