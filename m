Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B58DB90406
	for <lists+linux-can@lfdr.de>; Fri, 16 Aug 2019 16:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfHPOfa (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 16 Aug 2019 10:35:30 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35204 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfHPOfa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Aug 2019 10:35:30 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7GEZOgV077140;
        Fri, 16 Aug 2019 09:35:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565966124;
        bh=vlbqjmWm6UrmbI/wrz3N3RMC37ualZN+Sqgl+CiX7DY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Xim2l6TekbxS0Ic3GeBbRJI0hZ3Bpq4xYU81H2Hsxx4gqjlZuS7NE6pZmQvZYUpd+
         jU8LWY4akO1oSx8K4n8aPrC0ezKzmDiAWnVW+BQ35XWOTS1Q7sYP38p4LJWvAwZPVc
         8ibrYxqQ0p9OA+DteAoq+g43RBRsthv9dpW9ktiM=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7GEZOdJ047125
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Aug 2019 09:35:24 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 16
 Aug 2019 09:35:23 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 16 Aug 2019 09:35:23 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7GEZN7G034856;
        Fri, 16 Aug 2019 09:35:23 -0500
Subject: Re: [PATCH v12 4/5] can: tcan4x5x: Add tcan4x5x driver to the kernel
To:     Marc Kleine-Budde <mkl@pengutronix.de>, <wg@grandegger.com>
CC:     <linux-can@vger.kernel.org>
References: <20190509161109.10499-1-dmurphy@ti.com>
 <20190509161109.10499-4-dmurphy@ti.com>
 <9af58b1d-dda9-bb34-8797-37864e7d65fc@pengutronix.de>
 <9145f211-3b39-cc4f-c045-6ba07b603d71@pengutronix.de>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <5c43aa85-9be6-e044-082b-6f3aa9a2865a@ti.com>
Date:   Fri, 16 Aug 2019 09:35:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9145f211-3b39-cc4f-c045-6ba07b603d71@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Marc

On 8/16/19 3:58 AM, Marc Kleine-Budde wrote:
> On 8/16/19 9:48 AM, Marc Kleine-Budde wrote:
>> On 5/9/19 6:11 PM, Dan Murphy wrote:
>>> +static int regmap_spi_gather_write(void *context, const void *reg,
>>> +				   size_t reg_len, const void *val,
>>> +				   size_t val_len)
>>> +{
>>> +	struct device *dev = context;
>>> +	struct spi_device *spi = to_spi_device(dev);
>>> +	struct spi_message m;
>>> +	u32 addr;
>>> +	struct spi_transfer t[2] = {
>>> +		{ .tx_buf = &addr, .len = reg_len, .cs_change = 0,},
>>> +		{ .tx_buf = val, .len = val_len, },
>>> +	};
>>> +
>>> +	addr = TCAN4X5X_WRITE_CMD | (*((u16 *)reg) << 8) | val_len >> 3;
>> Why do you shift the len by 3? This means division by 8, but AFAICS the
>> chip expects the number of words (32 bit) you want to read.
> I see. Can you please test "[PATCH] can: tcan4x5x: fix data length in
> regmap write path", that I've just send to the mailinglist.

I will give it a test when I update the series for the interrupt binding 
change.

Dan


> Marc
>
