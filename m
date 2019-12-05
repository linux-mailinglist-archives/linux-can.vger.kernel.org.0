Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82BAA114625
	for <lists+linux-can@lfdr.de>; Thu,  5 Dec 2019 18:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbfLERo0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Dec 2019 12:44:26 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46460 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730195AbfLERo0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Dec 2019 12:44:26 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB5Hi8aW031074;
        Thu, 5 Dec 2019 11:44:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575567848;
        bh=B2u+1EXUJef+VRu1rBJvXbM0zJ7qX1rNIdIdh6bNero=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Q3JXPcJbFBQEDUSNRLbb6GuGRHBlATmYP9m+KM8YCnDxfRk89cDyTwH0kUsm/oaMM
         3cyZmE3+XPzybQPniK+QbyGbh0TIzxDjHVemRgYrkA4SMp0BZ2L4jK9IVNkFlJcdMt
         uIMLjick/RUJkiewxarhUa6zK/uy2so4h3Rs+E6o=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB5Hi870019722
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Dec 2019 11:44:08 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 5 Dec
 2019 11:44:08 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 5 Dec 2019 11:44:08 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB5Hi74E048911;
        Thu, 5 Dec 2019 11:44:08 -0600
Subject: Re: [PATCH] MAINTAINERS: add myself as maintainer of MCAN MMIO device
 driver
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Sriram Dash <sriram.dash@samsung.com>,
        <linux-kernel@vger.kernel.org>, <linux-can@vger.kernel.org>,
        <wg@grandegger.com>
CC:     <mchehab+samsung@kernel.org>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <robh@kernel.org>,
        <rcsekar@samsung.com>, <pankaj.dubey@samsung.com>,
        <pankj.sharma@samsung.com>
References: <CGME20191203043533epcas5p19bfc21e2b03db7f27c6d84cda6824d27@epcas5p1.samsung.com>
 <1575347349-32689-1-git-send-email-sriram.dash@samsung.com>
 <9c9b1f4d-e092-957a-150c-41f2348810e5@pengutronix.de>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <946fbd81-a024-04e4-74d8-90e9f5e9979a@ti.com>
Date:   Thu, 5 Dec 2019 11:42:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <9c9b1f4d-e092-957a-150c-41f2348810e5@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Marc

On 12/3/19 3:55 AM, Marc Kleine-Budde wrote:
> On 12/3/19 5:29 AM, Sriram Dash wrote:
>> Since we are actively working on MMIO MCAN device driver,
>> as discussed with Marc, I am adding myself as a maintainer.
>>
>> Signed-off-by: Sriram Dash <sriram.dash@samsung.com>
>> ---
> Added to linux-can.

When I add my maintainership for TCAN I am also going to add the 
m_can.c, m_can.h as well as the dt doc.

Or if you want me to add my email to the MMIO as well that is fine as we 
have devices that have the embedded Bosch IP as well

Dan

