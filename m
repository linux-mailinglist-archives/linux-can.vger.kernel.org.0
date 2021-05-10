Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B633A377B89
	for <lists+linux-can@lfdr.de>; Mon, 10 May 2021 07:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhEJFcp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 May 2021 01:32:45 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55060 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhEJFcn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 May 2021 01:32:43 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14A5VU8Z081177;
        Mon, 10 May 2021 00:31:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620624690;
        bh=CdW+YRXLk3uk5cWZMxSMVSm607ddrQRwN9EUo67GHoU=;
        h=Subject:CC:References:From:Date:In-Reply-To;
        b=pZw4ZfNGu/LI6x30dgWiJozhK3BJ/kQct6DXHqouVnCRQGw3nX9sEegZzTBXe9KZe
         tx4sCda87g3Gn4y50rC2Wq33JVlWSQi0uJ7fT+Yuczj/ZKHG0Cdb4PrUbmGf09OxQ0
         OgfYCK8ReLYiTeY8A01veuU8LMG9YF6tkGrMOGE4=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14A5VT4r093051
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 May 2021 00:31:29 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 10
 May 2021 00:31:29 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 10 May 2021 00:31:29 -0500
Received: from [10.250.235.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14A5VM3U057050;
        Mon, 10 May 2021 00:31:24 -0500
Subject: Re: [PATCH v3 0/2] MCAN: Add support for implementing transceiver as
 a phy
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>
References: <20210416114245.24829-1-a-govindraju@ti.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <2ac62e0b-58e0-0a5c-06c9-c2d5052c7a5d@ti.com>
Date:   Mon, 10 May 2021 11:01:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210416114245.24829-1-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi all,

On 16/04/21 5:12 pm, Aswath Govindraju wrote:
> The following series of patches add support for implementing the
> transceiver as a phy of m_can_platform driver.
> 
> TCAN1042 has a standby signal that needs to be pulled high for
> sending/receiving messages[1]. TCAN1043 has a enable signal along with
> standby signal that needs to be pulled up for sending/receiving
> messages[2], and other combinations of the two lines can be used to put the
> transceiver in different states to reduce power consumption. On boards
> like the AM654-idk and J721e-evm these signals are controlled using gpios.
> 
> These gpios are set in phy driver, and the transceiver can be put in
> different states using phy API. The phy driver is added in the series [3].
> 
> This patch series is dependent on [4].
> 
> changes since v2:
> - changed dev_err to dev_err_probe in patch 2
> - used mcan_class instead of priv to assign max bit rate
> - Picked up  Rob Herring's acked-by for patch 1
> 
> changes since v1:
> - Used the API devm_phy_get_optional() instead of 
>   devm_of_phy_get_optional_by_index()
> > [1] - https://www.ti.com/lit/ds/symlink/tcan1042h.pdf
> [2] - https://www.ti.com/lit/ds/symlink/tcan1043-q1.pdf
> [3] - https://lore.kernel.org/patchwork/project/lkml/list/?series=495511
> [4] - https://lore.kernel.org/patchwork/patch/1413286/
> 

Posted v4 for this series after adding phy_power_off in the path when
there is an error.

Thanks,
Aswath

> Faiz Abbas (2):
>   dt-bindings: net: can: Document transceiver implementation as phy
>   can: m_can: Add support for transceiver as phy
> 
>  .../devicetree/bindings/net/can/bosch,m_can.yaml    |  3 +++
>  drivers/net/can/m_can/m_can.c                       | 10 ++++++++++
>  drivers/net/can/m_can/m_can.h                       |  2 ++
>  drivers/net/can/m_can/m_can_platform.c              | 13 +++++++++++++
>  4 files changed, 28 insertions(+)
> 

