Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6ED159134D
	for <lists+linux-can@lfdr.de>; Fri, 12 Aug 2022 17:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbiHLPwI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 12 Aug 2022 11:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235618AbiHLPwH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 12 Aug 2022 11:52:07 -0400
Received: from mail.bitwise.fi (mail.bitwise.fi [109.204.228.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376A198A7C
        for <linux-can@vger.kernel.org>; Fri, 12 Aug 2022 08:52:04 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.bitwise.fi (Postfix) with ESMTP id 36CD4460029;
        Fri, 12 Aug 2022 18:45:02 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from mail.bitwise.fi ([127.0.0.1])
        by localhost (mustetatti.dmz.bitwise.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yRyiQvXwkhGK; Fri, 12 Aug 2022 18:44:59 +0300 (EEST)
Received: from [192.168.5.238] (fw1.dmz.bitwise.fi [192.168.69.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: anssiha)
        by mail.bitwise.fi (Postfix) with ESMTPSA id CBE49460008;
        Fri, 12 Aug 2022 18:44:59 +0300 (EEST)
Message-ID: <a2d8f85d-b912-4965-541f-995c543fe572@bitwise.fi>
Date:   Fri, 12 Aug 2022 18:44:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 00/15] can: kvaser_usb: Various fixes
Content-Language: en-US
To:     Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>
References: <20220708115709.232815-1-extja@kvaser.com>
From:   Anssi Hannula <anssi.hannula@bitwise.fi>
In-Reply-To: <20220708115709.232815-1-extja@kvaser.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi all!

On 8.7.2022 14.56, Jimmy Assarsson wrote:
> This patch series was originally posted by Anssi Hannula [1].
> Since v1 I've rebased the patches on top of commit
> b3b6df2c56d8 ("can: kvaser_usb: kvaser_usb_leaf: fix bittiming limits")
> and replaced a couple of patches with new ones.
>
> [1]
> https://lore.kernel.org/linux-can/20220516134748.3724796-1-anssi.hannula@bitwise.fi
>
> Anssi Hannula (10):
>   can: kvaser_usb_leaf: Fix overread with an invalid command
>   can: kvaser_usb: Fix use of uninitialized completion
>   can: kvaser_usb: Fix possible completions during init_completion
>   can: kvaser_usb_leaf: Set Warning state even without bus errors
>   can: kvaser_usb_leaf: Fix TX queue out of sync after restart
>   can: kvaser_usb_leaf: Fix CAN state after restart
>   can: kvaser_usb_leaf: Fix improved state not being reported
>   can: kvaser_usb_leaf: Fix wrong CAN state after stopping
>   can: kvaser_usb_leaf: Ignore stale bus-off after start
>   can: kvaser_usb_leaf: Fix bogus restart events
>
> Jimmy Assarsson (5):
>   can: kvaser_usb: kvaser_usb_leaf: Get capabilities from device
>   can: kvaser_usb: kvaser_usb_leaf: Rename {leaf,usbcan}_cmd_error_event
>     to {leaf,usbcan}_cmd_can_error_event
>   can: kvaser_usb: kvaser_usb_leaf: Handle CMD_ERROR_EVENT
>   can: kvaser_usb: Add struct kvaser_usb_busparams
>   can: kvaser_usb: Compare requested bittiming parameters with actual
>     parameters in do_set_{,data}_bittiming
>
>  drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  32 +-
>  .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 167 ++++--
>  .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 166 ++++--
>  .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 543 ++++++++++++++++--
>  4 files changed, 781 insertions(+), 127 deletions(-)
>

Sorry about the delay due to vacation.

I have tested the patchset on my devices, so if these are not yet applied
Tested-by: Anssi Hannula <anssi.hannula@bitwise.fi>
can be added to the new patches except for "can: kvaser_usb:
kvaser_usb_leaf: Get capabilities from device" which I sent a separate
message about.

-- 
Anssi Hannula / Bitwise Oy
+358 503803997

