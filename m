Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B93E1150B8
	for <lists+linux-can@lfdr.de>; Fri,  6 Dec 2019 13:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfLFM7C (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Dec 2019 07:59:02 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58502 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfLFM7B (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Dec 2019 07:59:01 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB6Cwrvr082285;
        Fri, 6 Dec 2019 06:58:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575637134;
        bh=9iiAvDMAiPAta7v9u8Fq9KmrsxQ+OYP31NRfT6WFynU=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=sabr6Zfeu8uNlYmMCA5MrLzMokZmjNuURDyOZorywrIRJu8d5zOuFgslNJ2RoI3kj
         NjzWLgAg34049gszoLzegVP6YyOwc7iV85Op0NeBaODnqWsXZz0kERj/+NJ/WL9WaZ
         SF/KvbLSO0PFLnqp74RGuvc0fZiqawunv/7jNBQY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB6CwrVZ101423
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Dec 2019 06:58:53 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 6 Dec
 2019 06:58:53 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 6 Dec 2019 06:58:53 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB6CwrjW076065;
        Fri, 6 Dec 2019 06:58:53 -0600
Subject: Re: tcan4x5x
To:     Sean Nyekjaer <sean@geanix.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <c16a87a4-5021-b25f-076c-18aa7b482baf@geanix.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <17034589-01c5-701b-e5c3-db8972c5ade0@ti.com>
Date:   Fri, 6 Dec 2019 06:56:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <c16a87a4-5021-b25f-076c-18aa7b482baf@geanix.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Sean

On 12/6/19 6:41 AM, Sean Nyekjaer wrote:
> Hi Dan,
>
> 3. Questions or comments :)
>
> All tests have been run with "net: m_can: Make wake-up gpio an 
> optional" applied.

Thanks for the tests and comments.  Patches are welcome.

>
> 1.
> From Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> reset-gpios = <&gpio1 27 GPIO_ACTIVE_LOW>;
> The reset gpio is ACTIVE_HIGH works if changed to this in my device-tree.
> I could do the patch for this if desired :)

Ack

>
>
> 2.
> From Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> - device-state-gpios: Input GPIO that indicates if the device is in
>  a sleep state or if the device is active.
>
> What pin is that exactly on the tcan4550 chip? I can't find a pin that 
> is matches this functionality.

This is the INH pin.  This is what our HW guys asked for.

We probably can make this pin optional as well.

>
> 3.
> When my board is booted, the reset line to the tcan4x5x is high.
> At 1. probe it's failing because it can't talk to the tcan device. We 
> are not waiting the required 700 μs described in the datasheet.

I am not seeing this requirement in the data sheet.  Maybe my data sheet 
is out of date.

Is that 700uS out of reset?

Dan

