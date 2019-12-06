Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58558115413
	for <lists+linux-can@lfdr.de>; Fri,  6 Dec 2019 16:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfLFPSa (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Dec 2019 10:18:30 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53806 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfLFPSa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Dec 2019 10:18:30 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB6FINv9026886;
        Fri, 6 Dec 2019 09:18:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575645503;
        bh=0xS278Wg1EJO6MDyr7pFAcc9LXtpGU58i3M7deJPc80=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=UcRHSDbkqsKaO8jmzzf6HMUJdMSKoqPsnsyqy4CvmMaumyiqfHgWExuICeFdJsuqV
         OesNdIftxG/fi5LarzxFWfT/VDEYFjx+80lD3QR+fO3e/VW9z1I9r+vH1m3epRsPs9
         SwKxToYTMjmgIrkmxxyUN63sI5xG/6q/orKS1Ahc=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB6FINLZ032221;
        Fri, 6 Dec 2019 09:18:23 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 6 Dec
 2019 09:18:22 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 6 Dec 2019 09:18:22 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB6FILIN061934;
        Fri, 6 Dec 2019 09:18:21 -0600
Subject: Re: tcan4x5x
To:     Sean Nyekjaer <sean@geanix.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <c16a87a4-5021-b25f-076c-18aa7b482baf@geanix.com>
 <17034589-01c5-701b-e5c3-db8972c5ade0@ti.com>
 <e5cf55ef-57ff-c3a9-fc2f-06a3c8fb1206@geanix.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <aa43b6ed-ff52-0c04-8478-945409149f6a@ti.com>
Date:   Fri, 6 Dec 2019 09:16:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <e5cf55ef-57ff-c3a9-fc2f-06a3c8fb1206@geanix.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Sean

On 12/6/19 7:54 AM, Sean Nyekjaer wrote:
>
>
> On 06/12/2019 13.56, Dan Murphy wrote:
>> This is the INH pin.  This is what our HW guys asked for.
>>
>> We probably can make this pin optional as well.
>
> Oh the INH pin is a high voltage output, for my device 12V :-)
> No really suited for a GPIO input...
>
> So please make that optional as well
>
Just checked it is optional already

Dan


