Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD78C51986F
	for <lists+linux-can@lfdr.de>; Wed,  4 May 2022 09:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237794AbiEDHld (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 May 2022 03:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbiEDHlc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 May 2022 03:41:32 -0400
Received: from mailgw.felk.cvut.cz (mailgw.felk.cvut.cz [147.32.82.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EE7B0E;
        Wed,  4 May 2022 00:37:56 -0700 (PDT)
Received: from mailgw.felk.cvut.cz (localhost.localdomain [127.0.0.1])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTP id 0ECC430B294B;
        Wed,  4 May 2022 09:37:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        cmp.felk.cvut.cz; h=cc:cc:content-transfer-encoding:content-type
        :content-type:date:from:from:in-reply-to:message-id:mime-version
        :references:reply-to:subject:subject:to:to; s=felkmail; bh=aTah0
        Z+PkY1vBvHcLGkzEoRPiH35qWhzUuaYXUknz+I=; b=OUSDQzJjvSS18f95oenBT
        1hff+35t0O0jwkdX1Sr/4t7cF5vNXxRliE05gzi0MCiG8qb61uWAlO/HPNsdFmvH
        5GBo5PptOpK7Y1Ib54fho5vpQVpEedZ8a0Fa34eKrzZNQVGHfnfMyDmrG4sfcfB8
        GXZRETuIzm2YRhv2kD82eKhFi2CxvxM/MqCAYwvQH2oVtI9fUmy2ux1RFRJVkwam
        slmdpJfJnKWutlewCIAvXaFon1RqX8AwS93WZrM57xJFUX1DljhLr/nlnIOXx+dk
        WZtnBFl9sauQ/OA2iCFs0OnPMcR4QQrACC4XGzzArUQOPvi6EXvUo8bF22xAz45i
        Q==
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTPS id 9E14830AE003;
        Wed,  4 May 2022 09:37:53 +0200 (CEST)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
        by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id 2447br93015420;
        Wed, 4 May 2022 09:37:53 +0200
Received: (from pisa@localhost)
        by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 2447brCv015419;
        Wed, 4 May 2022 09:37:53 +0200
X-Authentication-Warning: haar.felk.cvut.cz: pisa set sender to pisa@cmp.felk.cvut.cz using -f
From:   Pavel Pisa <pisa@cmp.felk.cvut.cz>
To:     "Marc Kleine-Budde" <mkl@pengutronix.de>
Subject: Re: [PATCH can-next] dt-binding: can: ctucanfd: include common CAN controller bindings
Date:   Wed, 4 May 2022 09:37:53 +0200
User-Agent: KMail/1.9.10
Cc:     linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Ondrej Ille <ondrej.ille@gmail.com>
References: <20220504062342.52529-1-mkl@pengutronix.de>
In-Reply-To: <20220504062342.52529-1-mkl@pengutronix.de>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202205040937.53137.pisa@cmp.felk.cvut.cz>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Marc,

thanks for update

On Wednesday 04 of May 2022 08:23:42 Marc Kleine-Budde wrote:
> Since commit
>
> | 1f9234401ce0 ("dt-bindings: can: add can-controller.yaml")
>
> there is a common CAN controller binding. Add this to the ctucanfd
> binding.
>
> Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> Cc: Ondrej Ille <ondrej.ille@gmail.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

if my reaction is expected then you can add my
Acked-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>

> ---
>  Documentation/devicetree/bindings/net/can/ctu,ctucanfd.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/net/can/ctu,ctucanfd.yaml
> b/Documentation/devicetree/bindings/net/can/ctu,ctucanfd.yaml index
> fb34d971dcb3..4635cb96fc64 100644
> --- a/Documentation/devicetree/bindings/net/can/ctu,ctucanfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/ctu,ctucanfd.yaml
> @@ -25,6 +25,9 @@ maintainers:
>    - Ondrej Ille <ondrej.ille@gmail.com>
>    - Martin Jerabek <martin.jerabek01@gmail.com>
>
> +allOf:
> +  - $ref: can-controller.yaml#
> +
>  properties:
>    compatible:
>      oneOf:

