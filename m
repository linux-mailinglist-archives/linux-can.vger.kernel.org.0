Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D1F598B4E
	for <lists+linux-can@lfdr.de>; Thu, 18 Aug 2022 20:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbiHRSgl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 18 Aug 2022 14:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiHRSgl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 18 Aug 2022 14:36:41 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADC5CE47B
        for <linux-can@vger.kernel.org>; Thu, 18 Aug 2022 11:36:39 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id s1so428200lfp.6
        for <linux-can@vger.kernel.org>; Thu, 18 Aug 2022 11:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=BvdJyTAm+t23sKrv/8vCD7Ya5VBhvBCAkS35stRcPCM=;
        b=IvzwtkAwinn48IPPF7aXne2i72R5vrq4E0UjHAdFLLySF2gL2LEbIAxm2G09/3Cq2u
         pBpVMXt/LN9mWPGyD9aQuIvPMES2EFVKOoLuM2Y9v7eM4hd3QEbccd78hVF5VY2FkPOs
         lrVvf46le9ouMv05ZUrDMKXqvJu9YRhsuf3hjajysMoOb0dZGFVV0KyquhUIFIwzS873
         oEGoeD1fiYHP6XyV/xYfZf1sDNL4g0P9SCENlSNpHmKyEKcFpXodhfyD6VxfKldMvEVo
         BMNH65z2blkvkmysJfdcTYYJ0QIWWxXlFcOAxB6SG1vTdoNrpR5KaxwGPI5HewdPgj8E
         luKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=BvdJyTAm+t23sKrv/8vCD7Ya5VBhvBCAkS35stRcPCM=;
        b=FcyTp1SC68kFTOb3Gj8cgJDteGEW4VmjyHFABJm10qe/gvflUnhCh8aV5NBjgbrDp8
         PT7VJ+wBQ6h5XkgvV4dAd7iNie1Fnu3zWEGT7aF/IscbTYpQqfqVc3EPeos4tSIFKcQx
         vD7XSuSHhfCt50Xix6ZQgd8ClgnfZ1BBcdHj0VLBPT2n4PcKDLlpyQ05nitHKK7fM9FF
         VQxejDMLDz41i92kA+Py9YHuaHF406G7Y5TqFvKRxTWJ92uYQrNnSdyGY+TqDupOubiJ
         06BRay99MK919CbNOVQZwGN5Yc4SDCQH82GhQdIhc3yLvGB+jHaO/k6t17pNaTLOIiHW
         tW9w==
X-Gm-Message-State: ACgBeo2yacKtcRXlm2iR0OqMYB0K86jc83zmcZoVdrm9pDzL1DjoMozZ
        CuAmPHkuN3h9mWa1X+I+oEsHTl0t0SqHhA==
X-Google-Smtp-Source: AA6agR6QsAPbgB/506sjCFT2hjAdDkVZBy1s9lXvlnU7erxjU0DNeQLg20hH5bnAc4y99Q7+7XIITQ==
X-Received: by 2002:a05:6512:2210:b0:48c:eba9:5493 with SMTP id h16-20020a056512221000b0048ceba95493mr1279073lfu.540.1660847797671;
        Thu, 18 Aug 2022 11:36:37 -0700 (PDT)
Received: from [192.168.16.196] (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id n24-20020a05651203f800b0048b0bc13615sm313478lfq.88.2022.08.18.11.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 11:36:37 -0700 (PDT)
Message-ID: <fb1ed28d-69a0-7b01-1081-6cfb398b3653@kvaser.com>
Date:   Thu, 18 Aug 2022 20:35:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 00/15] can: kvaser_usb: Various fixes
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Anssi Hannula <anssi.hannula@bitwise.fi>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>
References: <20220708115709.232815-1-extja@kvaser.com>
 <20220719184059.pzqgxsgl7hw3cdne@pengutronix.de>
 <48197e64-6dda-12d0-26ce-34054b23f7b4@kvaser.com>
 <20220816145048.leptfnx2wlk6vbdd@pengutronix.de>
From:   Jimmy Assarsson <extja@kvaser.com>
In-Reply-To: <20220816145048.leptfnx2wlk6vbdd@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 8/16/22 16:50, Marc Kleine-Budde wrote:
> On 19.07.2022 20:59:01, Jimmy Assarsson wrote:
>> On 7/19/22 20:40, Marc Kleine-Budde wrote:
>>> On 08.07.2022 13:56:54, Jimmy Assarsson wrote:
>>>> This patch series was originally posted by Anssi Hannula [1].
>>>> Since v1 I've rebased the patches on top of commit
>>>> b3b6df2c56d8 ("can: kvaser_usb: kvaser_usb_leaf: fix bittiming limits")
>>>> and replaced a couple of patches with new ones.
>>>
>>> Jimmy, as all of these patches went through your hands, they need your
>>> S-o-b. Can I add it while applying?
> 
> Jimmy, can you resend this series rebased again current net/main. Please
> add your S-o-b and take care of Anssi Hannula's issue in patch 04/15.
> 
> regards,
> Marc

Sure! Will try to fix this next week.

Best regards,
jimmy
