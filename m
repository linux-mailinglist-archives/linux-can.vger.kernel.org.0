Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A537516EEFA
	for <lists+linux-can@lfdr.de>; Tue, 25 Feb 2020 20:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731449AbgBYT3C (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 25 Feb 2020 14:29:02 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:33984 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731425AbgBYT3C (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Feb 2020 14:29:02 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01PHovn2044086;
        Tue, 25 Feb 2020 11:50:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582653057;
        bh=oUfgz4jpNu++9i18Bck0PQmtMSSoE4RnFSLpUGi+yRc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=F4DThKHvDUq/YhNYRfTUL6Z0MBQFb9KraV2xGrx/mr+bB3tXdsB7ZgmYTswdDCeZw
         C1lSvfr/ZeE189rlQRqdvlDCmqJ8n7A17RR/IZCyzev73hsAYrWj6MRjkTYYpsrs6e
         EuvgmfpJaOCQeVcpdzJkPyY6WpLVkCAQqgSmhkxU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01PHov0M049083;
        Tue, 25 Feb 2020 11:50:57 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 25
 Feb 2020 11:50:56 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 25 Feb 2020 11:50:56 -0600
Received: from [128.247.59.107] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01PHouID046652;
        Tue, 25 Feb 2020 11:50:56 -0600
Subject: Re: [PATCH linux-master 1/3] can: tcan4x5x: Move clock init to TCAN
 driver
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        <linux-kernel@vger.kernel.org>, <linux-can@vger.kernel.org>,
        <wg@grandegger.com>, <sriram.dash@samsung.com>
CC:     <davem@davemloft.net>
References: <20200131183433.11041-1-dmurphy@ti.com>
 <20200131183433.11041-2-dmurphy@ti.com>
 <06af6e1d-aec4-189c-378a-77af4073a1a6@ti.com>
 <fed1d801-e284-eada-d5b3-ae78089b3ead@pengutronix.de>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <e420c667-23d8-9739-1905-4a89570ddb72@ti.com>
Date:   Tue, 25 Feb 2020 11:45:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <fed1d801-e284-eada-d5b3-ae78089b3ead@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Marc

On 2/21/20 8:43 AM, Marc Kleine-Budde wrote:
> On 2/21/20 3:25 PM, Dan Murphy wrote:
>> Hello
>>
>> On 1/31/20 12:34 PM, Dan Murphy wrote:
>>> Move the clock discovery and initialization from the m_can framework to
>>> the registrar.  This allows for registrars to have unique clock
>>> initialization.  The TCAN device only needs the CAN clock reference.
>>>
>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>> ---
>> I would like to have these 3 patches reviewed and integrated (post
>> review) so I can work on other issues identified.
> Applied to linux-can-next/testing.

I am not seeing these patches applied

I am looking here 
https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/?h=testing

But they could be in a different repo

Dan

>
> tnx,
> Marc
>
