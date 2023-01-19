Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9C7673ED7
	for <lists+linux-can@lfdr.de>; Thu, 19 Jan 2023 17:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjASQa1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Jan 2023 11:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjASQaG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Jan 2023 11:30:06 -0500
Received: from mail3.ems-wuensche.com (mail3.ems-wuensche.com [81.169.186.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E8EE8CE6D
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 08:29:33 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id AD44DFF24E
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 16:29:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Score: -1.999
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id c14GKkXB5H_F for <linux-can@vger.kernel.org>;
        Thu, 19 Jan 2023 17:29:30 +0100 (CET)
Message-ID: <a75f4e0f-0e1d-058a-2a25-5581d930f603@ems-wuensche.com>
Date:   Thu, 19 Jan 2023 17:29:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     mkl@pengutronix.de, linux-can@vger.kernel.org
Cc:     wg@grandegger.com
References: <20230119154528.28425-1-uttenthaler@ems-wuensche.com>
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: Re: [PATCH 0/8] can: ems_pci: Add support for CPC-PCIe v3
In-Reply-To: <20230119154528.28425-1-uttenthaler@ems-wuensche.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Urgh, I missed a "{" and the patched driver does not compile. Be sure I 
successfully tested it yesterday with all three versions of the card. 
But when creating the patch series today I somehow introduced that bug. 
I will send the correct patches tomorrow.

BTW: scripts/checkpatch.pl -f 
/usr/src/linux/drivers/net/can/sja1000/ems_pci.c did not complain

Sorry for the noise
Gerhard

Am 19.01.23 um 16:45 schrieb Gerhard Uttenthaler:
> The CPC-PCIe v3 uses a Asix AX99100 instead of the discontinued
> PLX PCI9030 bridge chip. This patch series adds support for this
> card version and cleaned some code styling issues.
> 
> Gerhard Uttenthaler (8):
>    Fixed code style, copyright and email address
>    Added Asix AX99100 definitions
>    Initialize BAR registers
>    Added read/write register and post irq functions
>    Initialize CAN controller base addresses
>    Added IRQ enable
>    Deassert hardware reset
>    Added MODULE_AUTHOR
> 
>   drivers/net/can/sja1000/ems_pci.c | 152 ++++++++++++++++++++++--------
>   1 file changed, 113 insertions(+), 39 deletions(-)
> 
--
EMS Dr. Thomas Wuensche e.K.
Sonnenhang 3
85304 Ilmmuenster
HR Ingolstadt, HRA 170106

Phone: +49-8441-490260
Fax  : +49-8441-81860
http://www.ems-wuensche.com
