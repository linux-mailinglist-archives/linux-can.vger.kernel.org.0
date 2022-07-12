Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62967572747
	for <lists+linux-can@lfdr.de>; Tue, 12 Jul 2022 22:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiGLUak (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jul 2022 16:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiGLUaj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jul 2022 16:30:39 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C855CC783
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 13:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657657836;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=GMPAgEkfv409I3S1u5lySAC/P0/Z+dcfj1u/m/C99+g=;
    b=EgKynZzuB1pFgdU8TZJhsELZITqpJRLFTq/wlh1DD8soDnux+F+HmiMWGbmBGvLlZm
    D517GnS7TZBBKj24dr40fNyqY1PYzWVG87+wAuZY7GgDUq7nQLsEBHCZc0PIq0KbgNDQ
    1Ha3gJsUK4vZtOBrGXHsxY9IM8P53KKZGRaB1aMovn3nGY2j/sVYkbnF6sktV9nrgGr5
    iT766AIw4pGlshmhOOX+k34p8eZ7CgBPePSIK6Vkzczmxldo5Bbg4TIXUVngRc/FHCcG
    kvpYSvM6TJVtuL1S+82d7dxOrd1KabsgYsAjKRp9iOmSpWsch0TVSNUT0j44ozscgNG3
    uqvQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id t870d5y6CKUa0PS
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 12 Jul 2022 22:30:36 +0200 (CEST)
Message-ID: <0ebdf79d-784c-6e8f-32b2-5023cf9e38ad@hartkopp.net>
Date:   Tue, 12 Jul 2022 22:30:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: vcan OpenWRT
Content-Language: en-US
To:     Sergio Alberto Valdivia <salberto2000@hotmail.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <SN7PR14MB4270AE6DC8F68C87E6FD2876DD869@SN7PR14MB4270.namprd14.prod.outlook.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <SN7PR14MB4270AE6DC8F68C87E6FD2876DD869@SN7PR14MB4270.namprd14.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Sergio,

On 12.07.22 17:41, Sergio Alberto Valdivia wrote:
> Hi my name is Sergio, I’m trying to use can-utils in an Onion Omega 2 pro, which runs OpenWRT.
> 
> I have already installed the can-utils packages, but when I try to create a virtual CAN interface I get the following error: failed to find a module named vcan.

You need to install the vcan kernel module first.

E.g. on OpenWrt 21.02.3 it looks like this:

# opkg update

# opkg list | grep vcan
kmod-can-vcan - 5.4.188-1 - Similar to the network loopback devices, 
vcan offers a virtual local CAN interface.

# opkg install kmod-can-vcan
Installing kmod-can-vcan (5.4.188-1) to root...
Downloading 
https://downloads.openwrt.org/releases/21.02.3/targets/ath79/generic/packages/kmod-can-vcan_5.4.188-1_mips_24kc.ipk
Installing kmod-can (5.4.188-1) to root...
Downloading 
https://downloads.openwrt.org/releases/21.02.3/targets/ath79/generic/packages/kmod-can_5.4.188-1_mips_24kc.ipk
Configuring kmod-can.
Configuring kmod-can-vcan.

# lsmod | grep vcan
vcan                    2192  0

There we are ;-)

# ip link add type vcan

Then you can see vcan0 in

# cat /proc/net/dev

Best regards,
Oliver
