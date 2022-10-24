Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA94460BC42
	for <lists+linux-can@lfdr.de>; Mon, 24 Oct 2022 23:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiJXVdT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 24 Oct 2022 17:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbiJXVcn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 24 Oct 2022 17:32:43 -0400
Received: from mailgw.felk.cvut.cz (mailgw.felk.cvut.cz [147.32.82.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E135F60FF
        for <linux-can@vger.kernel.org>; Mon, 24 Oct 2022 12:39:48 -0700 (PDT)
Received: from mailgw.felk.cvut.cz (localhost.localdomain [127.0.0.1])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTP id D33A330B2962;
        Mon, 24 Oct 2022 13:42:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        cmp.felk.cvut.cz; h=cc:cc:content-transfer-encoding:content-type
        :content-type:date:from:from:in-reply-to:message-id:mime-version
        :references:reply-to:subject:subject:to:to; s=felkmail; bh=aRzlb
        6GSIhWUH/e9dt3yZ3EjK7ZywWcdFdi7hjAYeOM=; b=fBNZdjwkifp38AqhrBOvz
        VH4qR0NIBxQLeLmsFnh3YhFDFtGRLFJ/N5BI0bNT5nYvEUaYuqvukzB7/WtPcnhQ
        qRlu1RlvdkJ8OQ/ECodsHjYkrS0vvixf6/l6i7mxseVUz5rNQmJLa1FeHDQp6MIl
        oHFP0S8S+pJLDl0VPPeVezgFx2deqjSbQkxZ4Lhj25NfM4x/wfmsIZWrluZa7UKn
        LbZzTBdDjlDQ6khuWWLlJTrmbt9c4qDzDWNibiCxHF1Cp+B48yHoGT278dorWkzz
        IYjKssfSVvkEFoa9g0S7e2yTzpu8l/Yk86rf7gaICU/fdmX5Vc+kZny+IGEgSjSV
        A==
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTPS id 14B1B30ADE53;
        Mon, 24 Oct 2022 13:42:35 +0200 (CEST)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
        by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id 29OBgYug010759;
        Mon, 24 Oct 2022 13:42:34 +0200
Received: (from pisa@localhost)
        by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 29OBgYKN010758;
        Mon, 24 Oct 2022 13:42:34 +0200
X-Authentication-Warning: haar.felk.cvut.cz: pisa set sender to pisa@cmp.felk.cvut.cz using -f
From:   Pavel Pisa <pisa@cmp.felk.cvut.cz>
To:     "Marc Kleine-Budde" <mkl@pengutronix.de>
Subject: Re: [PATCH v5 2/4] can: ctucanfd: add HW timestamps to RX and error CAN frames
Date:   Mon, 24 Oct 2022 13:42:29 +0200
User-Agent: KMail/1.9.10
Cc:     Matej Vasilevski <matej.vasilevski@seznam.cz>,
        Ondrej Ille <ondrej.ille@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>, linux-can@vger.kernel.org
References: <20221012062558.732930-1-matej.vasilevski@seznam.cz> <202210162354.48915.pisa@cmp.felk.cvut.cz> <20221017121122.kt6adqz4dtqc2sy5@pengutronix.de>
In-Reply-To: <20221017121122.kt6adqz4dtqc2sy5@pengutronix.de>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202210241342.29170.pisa@cmp.felk.cvut.cz>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Marc,

On Monday 17 of October 2022 14:11:22 Marc Kleine-Budde wrote:
> On 16.10.2022 23:54:48, Pavel Pisa wrote:
> [...]
>
> > I hope/expect that it is not problem to call clk_prepare_enable twice
> > on same reference when the clocks are the same. As I read the code the
> > state is counted. If it is a problem then some if has to be put there
> > when the core and timestamp clock are the same.
>
> The clock prepare and enable are counting. If you call then twice, you
> have to call disable and unprepare twice, too, to shut it down. This is
> widely used in the kernel, e.g. if the same clock is passed to several
> IP cores.

Thanks for confirmation of my understanding.

As to move formward, is the referenced Matej Vasilevski's
series acceptable by you or do you see some problems still?

I have ACKed this patch, I consider it as functional
for mainline and good base for our further testing
and development.

Should I ACK others as well or Reviewed-by: Rob Herring
is enough for deice tree?

The last one is exactly reaction to your comment and the
documentation is evident.

Best wishes,

                Pavel
-- 
                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    RISC-V education: https://comparch.edu.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home

