Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36974148EE8
	for <lists+linux-can@lfdr.de>; Fri, 24 Jan 2020 20:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391660AbgAXTxT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 24 Jan 2020 14:53:19 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33234 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391581AbgAXTxT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 24 Jan 2020 14:53:19 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00OJrCoA082355;
        Fri, 24 Jan 2020 13:53:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579895592;
        bh=vG3tvGD/QRBqdgtOXjx5zOUsGHCK/ABAITDFK51OWYc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=i11zhh4EApu8nwWvLZH7bsEx134pNpg6OXOl7i64JLV/NRj9qIz7qcSgc02tmyWOD
         DNPRTrWkaz0dGxoq1jvYVMwkhj4mcqh16wGhmxcUAck/L3wRso7+v+XI1s10nWbGGb
         VlWO6CUV/tRJo44ctePh7SliyIxuyvhwy40VEWXc=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00OJrCCX090059
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Jan 2020 13:53:12 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 24
 Jan 2020 13:53:12 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 24 Jan 2020 13:53:12 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00OJrCv1053018;
        Fri, 24 Jan 2020 13:53:12 -0600
Subject: Re: [PATCH v2] can: tcan4x5x: Turn on the power before parsing the
 config
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20191210163204.28225-1-dmurphy@ti.com>
 <4a2e80f0-13c5-df7b-65af-25f86ca48f2a@pengutronix.de>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <3a67743b-aec6-ba4e-14a6-c2ab327e1eae@ti.com>
Date:   Fri, 24 Jan 2020 13:50:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <4a2e80f0-13c5-df7b-65af-25f86ca48f2a@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Marc

On 1/2/20 6:38 AM, Marc Kleine-Budde wrote:
> On 12/10/19 5:32 PM, Dan Murphy wrote:
>> The parse config function now performs action on the device either
>> reading or writing and a reset.  If the regulator is managed it needs
>> to be turned on.  So turn on the regulator if available if the parsing
>> fails then turn off the regulator.
> Another BTW:
> Consider converting the switching of the vsup to runtime_pm.
>
> Yet another one:
> Why do you disable the clocks in the error path of tcan4x5x_can_probe(),
> but never enable them?
>
>> out_clk:
>> 	if (!IS_ERR(mcan_class->cclk)) {
>> 		clk_disable_unprepare(mcan_class->cclk);
>> 		clk_disable_unprepare(mcan_class->hclk);
>> 	}
> - please move the clock handling from the m_can.c to the individual
>    driver
> - please move the clock handling to runtime_pm in the individual driver
> - remove the obsolete m_can_class_get_clocks()
> - make runtime_pm mandatory

Ack to the above I have made these changes locally.  Will submit next week.

Dan


> regards,
> Marc
>
