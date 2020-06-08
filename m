Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9CB1F1B00
	for <lists+linux-can@lfdr.de>; Mon,  8 Jun 2020 16:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbgFHO2F (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 8 Jun 2020 10:28:05 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47952 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgFHO2F (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 8 Jun 2020 10:28:05 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 058ERrIT017802;
        Mon, 8 Jun 2020 09:27:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591626473;
        bh=n+zne9QKzwemtxYh0/9VvDSOvejbuyJsP12nNN1zU1E=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QjUIRsYGB8DUlHu8T9JuZT87fmocvHzbrJfiIv+e1lTh44XrjpmNVrVynJbZ4issO
         1PTyabe3TuPTi6iaYpKvZkZ3jPA0M6cmz/D2ydX+MGi/5fDkhJVArfj4+l3oNyaw89
         DMk3CUg4XSIuQKRrVqKjrEOhEvJXQ+4ZqwWNULcE=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 058ERr5s078294
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Jun 2020 09:27:53 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 8 Jun
 2020 09:27:52 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 8 Jun 2020 09:27:52 -0500
Received: from [10.250.52.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 058ERqtI037595;
        Mon, 8 Jun 2020 09:27:52 -0500
Subject: Re: [PATCH] can: m_can_platform: fix m_can_runtime_suspend()
To:     Richard Genoud <richard.genoud@gmail.com>,
        Sriram Dash <sriram.dash@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Faiz Abbas <faiz_abbas@ti.com>
CC:     <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200608094348.12650-1-richard.genoud@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <b9510aa6-d865-7c4f-6730-dcd207bdb753@ti.com>
Date:   Mon, 8 Jun 2020 09:27:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200608094348.12650-1-richard.genoud@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Richard

On 6/8/20 4:43 AM, Richard Genoud wrote:
> Since commit f524f829b75a ("can: m_can: Create a m_can platform
> framework"), the can peripheral on STM32MP1 wasn't working anymore.
>
> The reason was a bad copy/paste maneuver that added a call to
> m_can_class_suspend() in m_can_runtime_suspend().

Are you sure it was a copy paste error?

Probably don't want to have an unfounded cause unless you know for 
certain it was this.

Dan


