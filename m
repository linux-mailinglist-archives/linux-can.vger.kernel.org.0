Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0588463801A
	for <lists+linux-can@lfdr.de>; Thu, 24 Nov 2022 21:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiKXUPb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 24 Nov 2022 15:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKXUPa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Nov 2022 15:15:30 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94A6B0400
        for <linux-can@vger.kernel.org>; Thu, 24 Nov 2022 12:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1669320927;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=3ygsWgrhXXE8axZOoLemAejOIr47WU1+gNB4+7gimYY=;
    b=UH9opzLkV4rsQzwLivM0xJneJOPoeNOVqgHJcdlDEEdLrH44u+aykw1Wh1EDTF335j
    iZEaIMKoW7KDvP0+UCwDDhsxqwzj/I8+mT2hI+Hm3sDXmH9jSVTHJ2zBWj3sj94T50Dj
    GQ/YEMsGU7JGu3CX1Iju+ihu5dlLzLwEoxtzotp71IGxpxXydgz1xJ/7C6utnFjIiXW6
    4jRGiTcyOqJvMzR8zqb/o+CxIX8aK/l8I+4vDE+0k9012XECeZ+Uebx+Avv3JLVgDGOM
    k0wsk1j8G5fg0IufBSGanfbFuk6JbyGhzP6V3xq93zr0TnwE5lKPEjxPVjYqzJiiWl3D
    lwnA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytISr6hZqJAw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d104::923]
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id Dde783yAOKFRJCW
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 24 Nov 2022 21:15:27 +0100 (CET)
Message-ID: <70b9e4a0-69ed-ba6a-ac3a-4e20aa9fc251@hartkopp.net>
Date:   Thu, 24 Nov 2022 21:15:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] can: mcba_usb: Fix termination command argument
To:     Yasushi SHOJI <yasushi.shoji@gmail.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        =?UTF-8?B?UmVtaWdpdXN6IEtvxYLFgsSFdGFq?= 
        <remigiusz.kollataj@mobica.com>,
        Yasushi SHOJI <yashi@spacecubics.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org
References: <20221123194406.80575-1-yashi@spacecubics.com>
 <20221123223410.sg2ixkaqg4dpe7ew@pengutronix.de>
 <CAELBRWJoQjLD9UaFUmqnFWT9HkPMNb4kKF+1EZwcfrn_WBwBYw@mail.gmail.com>
 <5a309931-ca81-5433-b437-5c8ec23c4d85@hartkopp.net>
 <CAELBRWKz57boSG1B=ONQ1Ax2TXw9FTHj36aG6p0VKp_tyHx2mg@mail.gmail.com>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAELBRWKz57boSG1B=ONQ1Ax2TXw9FTHj36aG6p0VKp_tyHx2mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Yashi,

On 24.11.22 14:13, Yasushi SHOJI wrote:

> I've checked with one of my colleagues and he told me I measured it wrong.

Ok.

> Here is a correction.
> 
> You can find the schematic of the analyzer in its user's guide
> https://www.microchip.com/en-us/development-tool/APGDT002
> or directly at https://ww1.microchip.com/downloads/aemDocuments/documents/APG/ProductDocuments/UserGuides/CAN-Bus-Analyzer-Users-Guide-DS50001848C.pdf
> 
> The schematics is at page 11.
> 
> Basically the "termination" controls the CAN_RES signal.  When it's
> low, R24 and R25 are connected to the bus.
> They are 56 Ohms.

Ah, that means 2 x 56 Ohms => 112 Ohms (nearly 120)

> With my patch, "termination 120" drives CAN_RES low and the resistors
> are active, and "termination 0" drives it high.

Thanks for the clarification!

Best regards,
Oliver
