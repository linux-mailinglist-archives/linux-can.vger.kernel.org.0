Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766F66379BC
	for <lists+linux-can@lfdr.de>; Thu, 24 Nov 2022 14:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiKXNNR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 24 Nov 2022 08:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiKXNNQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Nov 2022 08:13:16 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E46F442E5
        for <linux-can@vger.kernel.org>; Thu, 24 Nov 2022 05:13:15 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3704852322fso15294287b3.8
        for <linux-can@vger.kernel.org>; Thu, 24 Nov 2022 05:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bWwCH7Ke6zL6lPvm0vQ9LJkqr2mBvdw3fduAqhX9JmA=;
        b=MSn5ZlMMYptn+fZLt36olFLGAO/SffcObyEpEz6c2oafCU8lK5EUOkcsk5py/2E0aY
         /nGc9I7SQOIBWc/y6kuGZviZkLoK9ldGa1J1ChHqJxxyd96C8l2rLgbQXlOUv/6vxDp+
         BTDYN0rFkUOIsIWohzE11Bo6sk9awoUd17rl08M3KI3EXy4Rl1m8S2RARTCLjw+etDRu
         07Z/1srj3l9oO4VyYe1QbVd4cS8RJ+Zsu0I9Kz8S2EUehtcyq2ODOHZe06b5h/yfWEcH
         gLIY+6moTOpd3XA9ZMKRijRCz/pSa3eikFmr4tbzkCbcBFHU05kJquZUnGXBI7pr+Kxa
         WbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bWwCH7Ke6zL6lPvm0vQ9LJkqr2mBvdw3fduAqhX9JmA=;
        b=HzWURaE28J4IOh0GjxNOVO9lloHzkSjN3Cvh9YGWe9NUt3vHk4lwPMWhYLHSrYMwiG
         XHYZg453Ov7nFM8qF4po7Cin7ql0VNGrb9+J/STBRx6dmLEWNDguYJiD8YFxv4+cZp9o
         WQm3Le7wSHDzR5qF8QwZCNQVobbPY9yeWvQfymqU/VIezCwwgIwGk3Xf5of4suM7vq2q
         UjUBgH9zYyOgEqgx1bGrMfwKGxPbInpN17M+fIUj1jG9+1bWzKqmaJoYWpkDG6WUgpba
         fWnZcZTi71VAHCj1tvvVoqospvsxF7UMIdQRx0KT4UFGMBRf6VxxQh4f6AaAJ/V4SwQE
         f8jQ==
X-Gm-Message-State: ANoB5pk1DilqwN+pPq6Sla/kxN4UUvuBXMrkMlyQ1ncyhu8/zE3nMSs0
        pvktoTobEAlqAzUGK7Vhlf+DdowBP9nshpdf4Cg=
X-Google-Smtp-Source: AA0mqf7Gd14vnGBOedUjEDE2S3UmlVcd5R8M+0/KuPubfsqoGbu2jjPKBFnTK0+V1vrHvlg0kPJtt6SL3kTxSvFDQ7I=
X-Received: by 2002:a81:91c6:0:b0:3b7:19ad:82ed with SMTP id
 i189-20020a8191c6000000b003b719ad82edmr1224849ywg.85.1669295594604; Thu, 24
 Nov 2022 05:13:14 -0800 (PST)
MIME-Version: 1.0
References: <20221123194406.80575-1-yashi@spacecubics.com> <20221123223410.sg2ixkaqg4dpe7ew@pengutronix.de>
 <CAELBRWJoQjLD9UaFUmqnFWT9HkPMNb4kKF+1EZwcfrn_WBwBYw@mail.gmail.com> <5a309931-ca81-5433-b437-5c8ec23c4d85@hartkopp.net>
In-Reply-To: <5a309931-ca81-5433-b437-5c8ec23c4d85@hartkopp.net>
From:   Yasushi SHOJI <yasushi.shoji@gmail.com>
Date:   Thu, 24 Nov 2022 22:13:03 +0900
Message-ID: <CAELBRWKz57boSG1B=ONQ1Ax2TXw9FTHj36aG6p0VKp_tyHx2mg@mail.gmail.com>
Subject: Re: [PATCH] can: mcba_usb: Fix termination command argument
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        =?UTF-8?B?UmVtaWdpdXN6IEtvxYLFgsSFdGFq?= 
        <remigiusz.kollataj@mobica.com>,
        Yasushi SHOJI <yashi@spacecubics.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi again,

On Thu, Nov 24, 2022 at 7:09 PM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> I assumed "termination 0" results in "termination off" (=> no
> termination => very high resistor value) but in fact it gets around 20
> Ohms, which is a pretty heavy termination for a CAN bus.

I've checked with one of my colleagues and he told me I measured it wrong.

Here is a correction.

You can find the schematic of the analyzer in its user's guide
https://www.microchip.com/en-us/development-tool/APGDT002
or directly at https://ww1.microchip.com/downloads/aemDocuments/documents/APG/ProductDocuments/UserGuides/CAN-Bus-Analyzer-Users-Guide-DS50001848C.pdf

The schematics is at page 11.

Basically the "termination" controls the CAN_RES signal.  When it's
low, R24 and R25 are connected to the bus.
They are 56 Ohms.

With my patch, "termination 120" drives CAN_RES low and the resistors
are active, and "termination 0" drives it high.
-- 
             yashi
