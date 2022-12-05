Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A729D6425CB
	for <lists+linux-can@lfdr.de>; Mon,  5 Dec 2022 10:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiLEJaS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 5 Dec 2022 04:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiLEJaR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 5 Dec 2022 04:30:17 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905FB1573C
        for <linux-can@vger.kernel.org>; Mon,  5 Dec 2022 01:30:16 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ml11so26283380ejb.6
        for <linux-can@vger.kernel.org>; Mon, 05 Dec 2022 01:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FDSrwTaiYkeBidVUL1wtnaARBnuugrDybG4J4B7KjRQ=;
        b=Ek0fC49oSagD3Ul+L5jopBmUBuROZhyg8VcZqkQLTLLSW289nCIWsDjmqkq4Lfw3jn
         6JTFUVwUuz/ucY7tHQ7rjwKWqiLvK4QBoG2qCjn/7uTS+IxdOeI19s/gXRup1X8kZZTq
         NHkqvHENyjPX4T6Ko8Z0crqu/RPwk48aBb4ZhEv8pAjM1BZTGxx9FlYJfTEp57nCwAhy
         sB9Ntjtk70cgt8Zpy4oHiVoRCcCWyNwGuyvebX9d7ovvFMpTNf4VlyXVEl2QIm3wkPch
         s84BmvXPo33pDnXrac/2nfzR/irs9Ufr+UFiGKtljIbiwaTllL77iZJsEL4SSshmW1xY
         z4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDSrwTaiYkeBidVUL1wtnaARBnuugrDybG4J4B7KjRQ=;
        b=NFmawdBe473S/HdmVNfbUTpXgFH+spDqAtRmlPvSynSpnC6g1LSyv6pYJ/FPqXh1bO
         N5M9tQRxOzo9LdiGBe80vDOMCX3W1Xg5aMRTSIFxPBkT4JXkF1y+U8k7SC8Jq7xYNhbW
         s4lhxrVPozF0K3Vek8xDUXdEC80El57j0AlH17+l62n7n1E9iVJYBRWdymaa3tMswFq/
         KuuwqH+rLlIUqeykuMby5mYDWODKq1wDmmpTZr/JiVAeknVc82vnMwFaE9O6Nx/Pzqfb
         QAVbqf5PoIVZjDwXc7v5fwrojFJr6JHzNcoj1CGJl9DIAT2+fd2hY8A3V+VGC4a9RR/Q
         p7Ig==
X-Gm-Message-State: ANoB5pnTHmBFCEE+lHTiURKWi32O1JFL9C8YGwbpNYmygi/ceN/qfCAz
        k48vhGVPtKPBNpQZ/W+B3rSywa+yeEu2a4Tj
X-Google-Smtp-Source: AA0mqf4TucuADXPXXqE+4vnUK9TP8V9mLlh1wYufLkkd/GzpBoGLKx7nJ3ZNqqhERafJoj9+vyiZjg==
X-Received: by 2002:a17:906:a1a:b0:79e:9aea:7b60 with SMTP id w26-20020a1709060a1a00b0079e9aea7b60mr70679116ejf.444.1670232615061;
        Mon, 05 Dec 2022 01:30:15 -0800 (PST)
Received: from blmsp ([185.238.219.11])
        by smtp.gmail.com with ESMTPSA id o26-20020a170906289a00b007415f8ffcbbsm6136319ejd.98.2022.12.05.01.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 01:30:14 -0800 (PST)
Date:   Mon, 5 Dec 2022 10:30:13 +0100
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/15] can: tcan4x5x: Fix register range of first block
Message-ID: <20221205093013.kpsqyb3fhd5njubm@blmsp>
References: <20221116205308.2996556-1-msp@baylibre.com>
 <20221116205308.2996556-15-msp@baylibre.com>
 <20221202142810.kmd5m26fnm6lw2jh@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221202142810.kmd5m26fnm6lw2jh@pengutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On Fri, Dec 02, 2022 at 03:28:10PM +0100, Marc Kleine-Budde wrote:
> On 16.11.2022 21:53:07, Markus Schneider-Pargmann wrote:
> > According to the datasheet 0x1c is the last register in the first block,
> > not register 0x2c.
> 
> The datasheet "SLLSF91A – DECEMBER 2018 – REVISED JANUARY 2020" says:
> 
> | 8.6.1 Device ID and Interrupt/Diagnostic Flag Registers: 16'h0000 to
> | 16'h002F
> 
> While the last described register is at 0xc.

Sorry, not sure what I looked up here. The last described register is
0x10 SPI Error status mask in my datasheet:
'SLLSEZ5D – JANUARY 2018 – REVISED JUNE 2022'

I would prefer using the actual registers if that is ok with you, so
0x10 here because I assume the remaining registers have internal use or
maybe don't exist at all?! If there is an undocumented register that
needs to be used at some point we can still modify the ranges.

Also it seems the existing ranges are following the same logic and don't
list the whole range, just the documented registers.

The second range is wrong as well. The last register is 0x830, will fix.

Best,
Markus
