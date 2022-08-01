Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399E2587151
	for <lists+linux-can@lfdr.de>; Mon,  1 Aug 2022 21:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbiHATVl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 1 Aug 2022 15:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiHATVl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 1 Aug 2022 15:21:41 -0400
Received: from mailgw.felk.cvut.cz (mailgw.felk.cvut.cz [147.32.82.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D4025C4C;
        Mon,  1 Aug 2022 12:21:39 -0700 (PDT)
Received: from mailgw.felk.cvut.cz (localhost.localdomain [127.0.0.1])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTP id 4562930B294D;
        Mon,  1 Aug 2022 21:12:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        cmp.felk.cvut.cz; h=cc:cc:content-transfer-encoding:content-type
        :content-type:date:from:from:in-reply-to:message-id:mime-version
        :references:reply-to:subject:subject:to:to; s=felkmail; bh=2pWBh
        Ea9wyWcJUpGmxJYnmLEbr1TDmkAtzMF2Dliqj8=; b=Djbj4fH1O1BxeIvyGEjgt
        s0uMOIEKn1QbIAbfHOBZ1FaXdr3LLnhkhYvzm+nUfT881jxTMyleqx2/oxjYOowJ
        TYubXNoyY2WgICGBZb8lR9EBK8Wtomh5Qu6EzCkhHUC/lBrFYlEMpQaPdQhhi/G1
        AfBdS70lv7Pjw8Jt37Xsqnyb6bgsULYXkLNs/k/wnYnc+rtOz3A4W3YqPJO7g7N0
        hc+e1srw2aO/xA4Gw+byX1sohuS5CWXpXroMDQGW68M2QiBrxvWQzlTJavyrCxb5
        yesLsSIGq9HkZU0pMrc+ZeBMiuY+k5X5qN9CAci/ZCAx8E8UNVEX+8OFd3lFNUzW
        g==
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTPS id D880330AE002;
        Mon,  1 Aug 2022 21:12:43 +0200 (CEST)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
        by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id 271JCh8K007722;
        Mon, 1 Aug 2022 21:12:43 +0200
Received: (from pisa@localhost)
        by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 271JCh2Q007721;
        Mon, 1 Aug 2022 21:12:43 +0200
X-Authentication-Warning: haar.felk.cvut.cz: pisa set sender to pisa@cmp.felk.cvut.cz using -f
From:   Pavel Pisa <pisa@cmp.felk.cvut.cz>
To:     Matej Vasilevski <matej.vasilevski@seznam.cz>
Subject: Re: [PATCH v2 2/3] dt-bindings: can: ctucanfd: add another clock for HW timestamping
Date:   Mon, 1 Aug 2022 21:12:11 +0200
User-Agent: KMail/1.9.10
Cc:     Ondrej Ille <ondrej.ille@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "Marc Kleine-Budde" <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220801184656.702930-1-matej.vasilevski@seznam.cz> <20220801184656.702930-3-matej.vasilevski@seznam.cz>
In-Reply-To: <20220801184656.702930-3-matej.vasilevski@seznam.cz>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202208012112.11333.pisa@cmp.felk.cvut.cz>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Dear Matej Vasilevski,

thanks much for the work

On Monday 01 of August 2022 20:46:55 Matej Vasilevski wrote:
> Add second clock phandle to specify the timestamping clock.
> You can even use the same clock as the core, or define a fixed-clock
> if you need something custom.
>
> Signed-off-by: Matej Vasilevski <matej.vasilevski@seznam.cz>
Acked-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>


