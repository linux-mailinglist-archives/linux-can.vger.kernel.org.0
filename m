Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E711D377B6F
	for <lists+linux-can@lfdr.de>; Mon, 10 May 2021 07:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhEJFOG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 May 2021 01:14:06 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38014 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhEJFOF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 May 2021 01:14:05 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14A5CsO0081678;
        Mon, 10 May 2021 00:12:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620623574;
        bh=/ILRdSkhXloiMFf1uEKykB73GaM3pnrVf46TDj3RgUM=;
        h=Subject:CC:References:From:Date:In-Reply-To;
        b=O+VKvvUwpp88jb0agYKFqP0UmVwUhxWBKlzBAPwX8pqVoWjwx99RZzYK8hv6rvhYl
         xkHFWRfhuJYDnkg7fjIZ6G1s0v30ygavgVzYBBFUVGS2e7egCByZ9ThDUAXnk5VrFs
         s5IQnItj1CGRLBmeOuu8ZaF6raYoYPYZSva0IjOw=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14A5CsEc057763
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 May 2021 00:12:54 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 10
 May 2021 00:12:54 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 10 May 2021 00:12:54 -0500
Received: from [10.250.235.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14A5CnZ6011061;
        Mon, 10 May 2021 00:12:50 -0500
Subject: Re: [PATCH v5 0/3] CAN TRANSCEIVER: Add support for CAN transceivers
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-can@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
References: <20210416113058.23815-1-a-govindraju@ti.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <7845ae4a-abcc-1644-d47a-574656f3ebbb@ti.com>
Date:   Mon, 10 May 2021 10:42:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210416113058.23815-1-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi all,

On 16/04/21 5:00 pm, Aswath Govindraju wrote:
> The following series of patches add support for CAN transceivers.
> 
> TCAN1042 has a standby signal that needs to be pulled high for
> sending/receiving messages[1]. TCAN1043 has a enable signal along with
> standby signal that needs to be pulled up for sending/receiving
> messages[2], and other combinations of the two lines can be used to put the
> transceiver in different states to reduce power consumption. On boards
> like the AM654-idk and J721e-evm these signals are controlled using gpios.
> 
> Patch 1 rewords the comment that restricts max_link_rate attribute to have
> units of Mbps.
> 
> Patch 2 models the transceiver as a phy device tree node with properties
> for max bit rate supported, gpio properties for indicating gpio pin numbers
> to which standby and enable signals are connected.
> 
> Patch 2 adds a generic driver to support CAN transceivers.
> 
> changes since v4:
> - In patch 3 made the correction from mcan to CAN, in Kconfig help
> 
> changes since v3:
> - dropped patch 2(in v3)
> - changed the node name property in patch 3(in v3)
> - picked up Rob Herring's reviewed-by for patch 3(in v3)
> 
> changes since v2:
> - dropped 5 and 6 patches and to be sent via linux-can-next
> - added static keyword for can_transceiver_phy_probe()
> - changed enable gpio example to active high in patch 3
> - Rearranged the file names in alphabetical order in Makefile
>   and MAINTAINERS file
> 
> changes since v1:
> - Added patch 1 (in v2) that rewords the comment that restrict
>   max_link_rate attribute to have units of Mbps.
> - Added patch 2 (in v2) that adds an API for
>   devm_of_phy_optional_get_by_index
> - Patch 1 (in v1)
>   - updated MAINTAINERS file
> - Patch 2 (in v1)
>   - replaced m_can with CAN to make the driver independent of CAN driver
>   - Added prefix CAN_TRANSCEIVER for EN_PRESENT and STB_PRESENT
>   - Added new line before return statements in power_on() and power_off
>   - Added error handling patch for devm_kzalloc()
>   - used the max_link_rate attribute directly instead of dividing it by
>     1000000
>   - removed the spaces before GPIOD_OUT_LOW in devm_gpiod_get()
>   - Corrected requested value for standby-gpios to GPIOD_OUT_HIGH
>   - Updated MAINTAINERS file
> - Patch 3 (in v1)
>   - replaced minItems with maxItems
>   - Removed phy-names property as there is only one phy
> - Patch 4 (in v1)
>   - replaced dev_warn with dev_info when no transceiver is found
>   - Added struct phy * field in m_can_classdev struct
>   - moved phy_power_on and phy_power_off to m_can_open and m_can_close
>     respectively
>   - Moved the check for max_bit_rate to generice transceiver driver
> 
> [1] - https://www.ti.com/lit/ds/symlink/tcan1042h.pdf
> [2] - https://www.ti.com/lit/ds/symlink/tcan1043-q1.pdf
> 

Posted v6 of this series after making small changes in patch 3 which
include copyright right year change and web address change to https.

Thanks,
Aswath


> Aswath Govindraju (3):
>   phy: core: Reword the comment specifying the units of max_link_rate to
>     be Mbps
>   dt-bindings: phy: Add binding for TI TCAN104x CAN transceivers
>   phy: phy-can-transceiver: Add support for generic CAN transceiver
>     driver
> 
>  .../bindings/phy/ti,tcan104x-can.yaml         |  56 +++++++
>  MAINTAINERS                                   |   2 +
>  drivers/phy/Kconfig                           |   9 ++
>  drivers/phy/Makefile                          |   1 +
>  drivers/phy/phy-can-transceiver.c             | 146 ++++++++++++++++++
>  include/linux/phy/phy.h                       |   2 +-
>  6 files changed, 215 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
>  create mode 100644 drivers/phy/phy-can-transceiver.c
> 

