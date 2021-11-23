Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F9F459D99
	for <lists+linux-can@lfdr.de>; Tue, 23 Nov 2021 09:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhKWIRr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Nov 2021 03:17:47 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35762 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhKWIRr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Nov 2021 03:17:47 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AN8ESHh024421;
        Tue, 23 Nov 2021 02:14:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637655268;
        bh=y5EkiJ7SMkpoSDDEcOeXgHBrlYWqeQNdWDeIJEVvZYk=;
        h=Subject:CC:References:From:Date:In-Reply-To;
        b=mY19MsNzNTLzrQNmAD4U70WVMUmzGu2bPhSaBnORwJOzyAn2lRd35+qIZrpHgje9L
         K+aFWfRsiiIrA7/B0C8OCETvcMbLK+rZ2JPhlZX7Bqjy67cTzPb1xNoQdAYGnvBTG9
         RMsVJ7yBee1vEZds0EkmVk7rfAndG9pMLAI94TRA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AN8ES1C006944
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Nov 2021 02:14:28 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 23
 Nov 2021 02:14:28 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 23 Nov 2021 02:14:28 -0600
Received: from [10.250.232.185] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AN8EOPw107046;
        Tue, 23 Nov 2021 02:14:25 -0600
Subject: Re: [PATCH RFC v2 0/4] MUX: Add support for reading enable state from
 DT
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-can@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
References: <20211122125624.6431-1-a-govindraju@ti.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <b9ad641d-e697-fcd7-a113-685d371bb0ba@ti.com>
Date:   Tue, 23 Nov 2021 13:44:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211122125624.6431-1-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi All,

On 22/11/21 6:26 pm, Aswath Govindraju wrote:
> - The following series of patches add support for reading the state of the
>   mux to be set for enabling given device.
> - As these are RFC patches I have combined them into a single series for
>   better understanding of the reason behind making this change.
> 
> Changes since v1:
> - Added support for reading the enable state from DT instead of hardcoding
>   the state to be set to 1.
> - Made relavent changes in the bindings
> 
> Link to v1,
> - https://patchwork.kernel.org/project/linux-phy/list/?series=578863&state=*
> 
> Aswath Govindraju (4):
>   dt-bindings: mux: Increase the number of arguments in mux-controls
>   dt-bindings: phy: ti,tcan104x-can: Document mux-controls property
>   mux: Add support for reading mux enable state from DT
>   phy: phy-can-transceiver: Add support for setting mux
> 

Thank you for the comments. I have made changes based on the comments
received and posted a v3 of this series.

Regards,
Aswath

>  .../devicetree/bindings/mux/gpio-mux.yaml     |  2 +-
>  .../bindings/mux/mux-controller.yaml          |  2 +-
>  .../bindings/phy/ti,tcan104x-can.yaml         |  8 ++++++
>  drivers/mux/core.c                            | 20 ++++++++++++--
>  drivers/phy/phy-can-transceiver.c             | 26 +++++++++++++++++++
>  include/linux/mux/consumer.h                  |  1 +
>  include/linux/mux/driver.h                    |  1 +
>  7 files changed, 56 insertions(+), 4 deletions(-)
> 

