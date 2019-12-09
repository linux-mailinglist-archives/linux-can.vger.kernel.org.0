Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A12B911766A
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2019 20:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfLIT4G (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Dec 2019 14:56:06 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43220 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfLIT4G (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 9 Dec 2019 14:56:06 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB9JtsCo024481;
        Mon, 9 Dec 2019 13:55:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575921354;
        bh=vN6CtjHd6eXapL0cAtpdOKr+tHvzfM2V7/7AyPphVOo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ulO5xyFRoDD/kInT/H3N7mnxynhtHPfLPK3dvs7iqodxFFll/Iq8QyO9h61+9YQA9
         FPOV4XDpYnnyKbrtXlj0mhAVSsM6lysO+BwXqnuowhLh+dP1dTczgBUxZIuV5oogCi
         tw52tvv1lr/ES4AMA6h5iMZktHRyFX3BLCQs8JWo=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB9Jts5r068432;
        Mon, 9 Dec 2019 13:55:54 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Dec
 2019 13:55:52 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Dec 2019 13:55:53 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB9JtqmE123541;
        Mon, 9 Dec 2019 13:55:52 -0600
Subject: Re: [PATCH v2] can: m_can: remove double clearing of clock stop
 request bit
To:     Sean Nyekjaer <sean@geanix.com>, <sriram.dash@samsung.com>,
        <pankj.sharma@samsung.com>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>
CC:     <martin@geanix.com>
References: <20191209192949.998976-1-sean@geanix.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <cdf36996-376a-4755-75ff-27c441a317ad@ti.com>
Date:   Mon, 9 Dec 2019 13:53:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191209192949.998976-1-sean@geanix.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Sean

On 12/9/19 1:29 PM, Sean Nyekjaer wrote:
> In m_can_config_endisable the CSR bit cleared 2 times while enabling
> configuration mode.
> The CSR should always be cleared when writing to the CCCR register.
>
> According to the datasheet:
> If a Read-Modify-Write operation is performed in Standby mode a
> CSR = 1 will be read back but a 0 should be written to it.

I am not understanding why you need to have this statement in the commit 
message.

And are you referring to the Bosch IP data sheet or the TCAN data sheet?

If it is the TCAN data sheet then this reference may not apply to the 
MMIO version.

It would be best to denote which datasheet you are talking about here.

Other then that I agree with the change and will ACK once I understand 
what data sheet you are talking about.

Dan

