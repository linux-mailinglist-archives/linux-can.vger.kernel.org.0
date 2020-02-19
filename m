Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51A1F164513
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2020 14:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgBSNMQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 19 Feb 2020 08:12:16 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47262 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbgBSNMQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 19 Feb 2020 08:12:16 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01JDC3LO065242;
        Wed, 19 Feb 2020 07:12:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582117923;
        bh=B/O91ZYHGjTEacr23ckeGZ3NbDZ9epolpD1ChKHO78s=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NHM1TGu+mOsa6kL8O4ZCmpz5we8vGZ1NRM8JYIcwGE+HCeI9MakLQvq/312aHfpNP
         uomBnpwDmNBivJM6qH7XSevgqXu8AKNhYbtLzfZbT9EtzNRQIavKtBe0YHdJMsbJU+
         iL4FAP2OksTNoEMkTCELFG7FXnq/3zqV119d1rgQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01JDC37c096025
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Feb 2020 07:12:03 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 19
 Feb 2020 07:12:03 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 19 Feb 2020 07:12:03 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01JDC2QZ056606;
        Wed, 19 Feb 2020 07:12:03 -0600
Subject: Re: [PATCH linux-master 0/3] MCAN updates for clock discovery
To:     <linux-kernel@vger.kernel.org>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>, <wg@grandegger.com>,
        <sriram.dash@samsung.com>
CC:     <davem@davemloft.net>
References: <20200131183433.11041-1-dmurphy@ti.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <a97ed7ef-e95a-af32-4d01-2ed7c2c08c20@ti.com>
Date:   Wed, 19 Feb 2020 07:07:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200131183433.11041-1-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Bump

On 1/31/20 12:34 PM, Dan Murphy wrote:
> Hello
>
> These are the initial fixes for issues found in and requested in
> https://lore.kernel.org/patchwork/patch/1165091/
>
> For the clock discovery and initialization.
>
> Dan
>
> Dan Murphy (3):
>    can: tcan4x5x: Move clock init to TCAN driver
>    can: m_can_platform: Move clock discovery and init to platform
>    can: m_can: Remove unused clock function from the framework
>
>   drivers/net/can/m_can/m_can.c          | 16 ------
>   drivers/net/can/m_can/m_can.h          |  3 -
>   drivers/net/can/m_can/m_can_platform.c | 37 +++++++++---
>   drivers/net/can/m_can/tcan4x5x.c       | 78 +++++++++++++++++++-------
>   4 files changed, 89 insertions(+), 45 deletions(-)
>
