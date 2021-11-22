Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D30458EEE
	for <lists+linux-can@lfdr.de>; Mon, 22 Nov 2021 14:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbhKVNH2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 Nov 2021 08:07:28 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43510 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhKVNH0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Nov 2021 08:07:26 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AMD4CfE110222;
        Mon, 22 Nov 2021 07:04:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637586252;
        bh=cgfUQb5H+/q89FEobokpGFktiAaiufefxSB1SXD7M2c=;
        h=Subject:CC:References:From:Date:In-Reply-To;
        b=kjUYxnjlY/l9kWVVKFvafoneBn9Aj9CxTSfdKDAVU/saHvI6fYimjGuIRxO+a+F5S
         wnKfi+FrbMkQg2xl6T4rjxoLOMA0IgMxes+kdqaBnGRc+KY9z6n84frgacY6Du78wS
         /VeV26xcz8TV71FZBEBC098raB8ipnlg6vuOfsJo=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AMD4CCr128275
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Nov 2021 07:04:12 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 22
 Nov 2021 07:04:12 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 22 Nov 2021 07:04:12 -0600
Received: from [10.250.232.185] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AMD49wq127891;
        Mon, 22 Nov 2021 07:04:09 -0600
Subject: Re: [PATCH RFC 0/2] CAN TRANSCEIVER: Add support for setting mux
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-can@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20211111164313.649-1-a-govindraju@ti.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <cf9c9534-92a8-4c7f-fdb6-43b40768ec65@ti.com>
Date:   Mon, 22 Nov 2021 18:34:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211111164313.649-1-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi all,

On 11/11/21 10:13 pm, Aswath Govindraju wrote:
> On some boards, for routing CAN signals from controller to transceiver,
> muxes might need to be set. Therefore, add support for setting the mux by
> reading the mux-controls property from the device tree node.
> 
> Aswath Govindraju (2):
>   dt-bindings: phy: ti,tcan104x-can: Document mux-controls property
>   phy: phy-can-transceiver: Add support for setting mux
> 

Thank you for the comments. I have posted a v2 for this series after
making the changes that were requested.

Link to v2,
- https://patchwork.kernel.org/project/linux-phy/list/?series=583917

Thanks,
Aswath

>  .../bindings/phy/ti,tcan104x-can.yaml         |  6 ++++++
>  drivers/phy/phy-can-transceiver.c             | 21 +++++++++++++++++++
>  2 files changed, 27 insertions(+)
> 

