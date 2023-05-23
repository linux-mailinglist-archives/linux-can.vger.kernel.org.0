Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D7C70D997
	for <lists+linux-can@lfdr.de>; Tue, 23 May 2023 11:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbjEWJxl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 May 2023 05:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236024AbjEWJx1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 May 2023 05:53:27 -0400
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B731720
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:52:42 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4f3a873476bso5917414e87.1
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1684835501; x=1687427501;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzHmGHtAPNzjwDQJv9onWNYBcfZjAcjEWcIMKRc8kPc=;
        b=ILLlvJC1xkhoghYoJAJttvyjmdwxI1JkHaWj6e/Pr+2PNgCUmDkrIECDgi/ah4aKoX
         ZFf582z4thNPK8VmGp1F9wD8sy9x8UfztXoE0Pa0f75CMNgfVAy2cjlO5gn9WzseRDi2
         9ORbIGSnGbzcjjS2ekZo4Pufng6StLdk5Y/XJNVgXYGRhEEQ/LLMnPj/7A/z5q07f9F6
         Be8KutC6sRPauZIoMWYfaf/x+v+YHVEna2M4xdgJl/yxhVuM7morhYen5WLZKASo1Siy
         XX8h0SOdl2iTj6tDpOuI+7eE2hjk+992WZH7ISKVoDCd2bMSQcMOjV4L5enw5FreLMAL
         pp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684835501; x=1687427501;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mzHmGHtAPNzjwDQJv9onWNYBcfZjAcjEWcIMKRc8kPc=;
        b=a06v3xrukdYRxJiXTpgwoGN7L+FPXT1An2aYW9shvvVbVVx5IjBe2s+d1tLaKaJ41u
         Iu4ZUXmW9E1PzenfZLWsmSoNzPXskJIQX4Uw4M/qOdrOuLuKI8jlVDUAkepJdJcDE7PK
         AgTfBarTx4m9YwXAAvAPcMX7UxuEaiZ6+OHCI0FDpHRdoC46rI/QUIVRi2O0xwdyRpdA
         95W18ujorIgSXl3eKtNO7m1c4ADXdvbyD9fAwRrskdKkoyhjiTDJsvFjRlElG5xwiG7A
         YKYz7t2irIWtaOq+NOpdYdeR750yXZr54sR3faER633ZXNhooF1GiaVKBEcb7Nhn83ty
         CssA==
X-Gm-Message-State: AC+VfDw2ksRsQ2PhCBLlizSDHdWuzoCat8E79gEY+bc6wYBJ3Zt+UgA7
        qgkGd4BBkH+NMQF6HtUhVb8XIA==
X-Google-Smtp-Source: ACHHUZ4nfjtsMuLrv41ehj0aUIzx2UQUfXzl57W3Spipe4awAkU2F4sFyCDOiGaERhSd8jxNor81Kw==
X-Received: by 2002:a19:f009:0:b0:4f4:b10a:34af with SMTP id p9-20020a19f009000000b004f4b10a34afmr1326957lfc.36.1684835500711;
        Tue, 23 May 2023 02:51:40 -0700 (PDT)
Received: from [10.8.0.3] (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id r13-20020ac25a4d000000b004f4589808cfsm862100lfn.300.2023.05.23.02.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 02:51:40 -0700 (PDT)
Subject: Re: [PATCH 0/3] can: kvaser_pciefd: Add support for new Kvaser PCI
 Express devices
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>
References: <20230523094354.83792-1-extja@kvaser.com>
 <20230523094354.83792-14-extja@kvaser.com>
From:   Jimmy Assarsson <extja@kvaser.com>
Message-ID: <7fead28e-30f6-ea22-a07f-cdd27a533bb7@kvaser.com>
Date:   Tue, 23 May 2023 11:51:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20230523094354.83792-14-extja@kvaser.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2023-05-23 11:43, Jimmy Assarsson wrote:
> This patch series adds support for a range of new Kvaser PCI Express
> devices based on the SmartFusion2 SoC, to the kvaser_pciefd driver.
> 
> In the first patch, the hardware specific constants and functions are
> moved into a driver_data struct.
> 
> In the second patch, we add the new devices and their hardware specific
> constants and functions.
> 
> In the last patch, most of the register reading and writing + shifting
> and masking, are wrapped in macros, to simplify the functions.
> 
> 
> Note: This series depends on the changes in xxx

xxx should be [PATCH 00/12] can: kvaser_pciefd: Fixes and improvments [1]

[1] https://lore.kernel.org/linux-can/20230523094354.83792-1-extja@kvaser.com/

/jimmy
