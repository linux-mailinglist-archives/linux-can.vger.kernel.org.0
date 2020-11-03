Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC0F2A41FB
	for <lists+linux-can@lfdr.de>; Tue,  3 Nov 2020 11:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgKCKdQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 3 Nov 2020 05:33:16 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:33515 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgKCKdQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 3 Nov 2020 05:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1604399590;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=RfOniR0Ct/ucetmPh/xM/62EOLZP+mPbOTOCkJG0atM=;
        b=ULXb6rNsajf11+TaMgzlddzAe+CKRsMcW5Z68P/aopiwK5ibf2/Oyam8g4hRn/lrbl
        0pCzZAd+2CpPBnpVhqZ42FCclfrXkjkG/ySCKhPK32qsVmjclsao0k6wA7pzW2m4iN5c
        v5qkz7A3VIQV664OvXuOpKTCa3fXjOdRVZ9kNKz7JUA6KZMLUY7nOPwSchivk9XgRi+O
        9jtJmz2W8dihuTsQFIUOdc44rAI5cj+IJgqnt3LYWkDlfeQcfiYUv8x4Q0+QkCzdd08Y
        ZVffxO3FZFbB/CyWMf+C20N2Gal9sgYPByHyoKHbY93l5zbvqM3z8yYFa3HH0OIdzEAJ
        kkbA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR9J8topw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.3.0 SBL|AUTH)
        with ESMTPSA id L010bewA3AX7EeX
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 3 Nov 2020 11:33:07 +0100 (CET)
Subject: Re: [PATCH v3 0/4] Introduce optional DLC element for Classic CAN
To:     mkl@pengutronix.de, mailhol.vincent@wanadoo.fr
Cc:     linux-can@vger.kernel.org
References: <20201029083218.41505-1-socketcan@hartkopp.net>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <05f5257e-2ece-d9d4-2481-57b05b961d10@hartkopp.net>
Date:   Tue, 3 Nov 2020 11:33:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201029083218.41505-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Marc,

I did some more testing with different CAN-USB adapters and feel pretty 
comfortable on the below patch set now.

Would you think this is something for can-next?

If so, I would also start to extend the can-gw.

On 29.10.20 09:32, Oliver Hartkopp wrote:
> Introduce improved DLC handling for Classic CAN with introduces a new
> element 'len8_dlc' to the struct can_frame and additionally rename
> the 'can_dlc' element to 'len' as it represents a plain payload length.
> 
> Before implementing the CAN_CTRLMODE_CC_LEN8_DLC handling on driver level
> this patch set cleans up and renames the relevant code.
> 
> No functional changes.
> 
> This patch set is based on mkl/linux-can.git (testing branch).

Btw. here are still some patches that haven't been pushed upstream.

Best,
Oliver

> 
> Changes in v2:
>    - rephrase commit message of patch 4 about can_dlc replacement
> 
> Changes in v3:
>    - remove unnecessarily introduced u8 cast in flexcan.c
> 
> Oliver Hartkopp (4):
>    can: add optional DLC element to Classical CAN frame structure
>    can: rename get_can_dlc() macro with can_get_cc_len()
>    can: remove obsolete get_canfd_dlc() macro
>    can: replace can_dlc as variable/element for payload length
> 
>   Documentation/networking/can.rst              |  6 ++--
>   drivers/net/can/at91_can.c                    | 14 ++++----
>   drivers/net/can/c_can/c_can.c                 | 20 +++++------
>   drivers/net/can/cc770/cc770.c                 | 14 ++++----
>   drivers/net/can/dev.c                         | 10 +++---
>   drivers/net/can/flexcan.c                     |  4 +--
>   drivers/net/can/grcan.c                       | 10 +++---
>   drivers/net/can/ifi_canfd/ifi_canfd.c         |  6 ++--
>   drivers/net/can/janz-ican3.c                  | 20 +++++------
>   drivers/net/can/kvaser_pciefd.c               |  4 +--
>   drivers/net/can/m_can/m_can.c                 |  6 ++--
>   drivers/net/can/mscan/mscan.c                 | 20 +++++------
>   drivers/net/can/pch_can.c                     | 14 ++++----
>   drivers/net/can/peak_canfd/peak_canfd.c       | 16 ++++-----
>   drivers/net/can/rcar/rcar_can.c               | 14 ++++----
>   drivers/net/can/rcar/rcar_canfd.c             |  8 ++---
>   drivers/net/can/rx-offload.c                  |  2 +-
>   drivers/net/can/sja1000/sja1000.c             | 10 +++---
>   drivers/net/can/slcan.c                       | 32 ++++++++---------
>   drivers/net/can/softing/softing_fw.c          |  2 +-
>   drivers/net/can/softing/softing_main.c        | 14 ++++----
>   drivers/net/can/spi/hi311x.c                  | 20 +++++------
>   drivers/net/can/spi/mcp251x.c                 | 20 +++++------
>   .../net/can/spi/mcp251xfd/mcp251xfd-core.c    |  4 +--
>   drivers/net/can/sun4i_can.c                   | 10 +++---
>   drivers/net/can/ti_hecc.c                     |  8 ++---
>   drivers/net/can/usb/ems_usb.c                 | 16 ++++-----
>   drivers/net/can/usb/esd_usb2.c                | 16 ++++-----
>   drivers/net/can/usb/gs_usb.c                  | 14 ++++----
>   .../net/can/usb/kvaser_usb/kvaser_usb_core.c  |  2 +-
>   .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 20 +++++------
>   .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 22 ++++++------
>   drivers/net/can/usb/mcba_usb.c                | 10 +++---
>   drivers/net/can/usb/peak_usb/pcan_usb.c       | 14 ++++----
>   drivers/net/can/usb/peak_usb/pcan_usb_fd.c    | 14 ++++----
>   drivers/net/can/usb/peak_usb/pcan_usb_pro.c   | 14 ++++----
>   drivers/net/can/usb/ucan.c                    | 20 +++++------
>   drivers/net/can/usb/usb_8dev.c                | 14 ++++----
>   drivers/net/can/xilinx_can.c                  | 12 +++----
>   include/linux/can/dev.h                       |  9 +++--
>   include/linux/can/dev/peak_canfd.h            |  2 +-
>   include/uapi/linux/can.h                      | 36 ++++++++++++-------
>   include/uapi/linux/can/netlink.h              |  1 +
>   net/can/af_can.c                              |  2 +-
>   net/can/gw.c                                  |  2 +-
>   net/can/j1939/main.c                          |  4 +--
>   46 files changed, 281 insertions(+), 271 deletions(-)
> 
