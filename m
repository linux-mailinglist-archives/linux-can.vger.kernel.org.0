Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E256B73A490
	for <lists+linux-can@lfdr.de>; Thu, 22 Jun 2023 17:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjFVPQr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Jun 2023 11:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjFVPQq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Jun 2023 11:16:46 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1A710A
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 08:16:45 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b466066950so92647221fa.2
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 08:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1687447003; x=1690039003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q3ttuXOUR5H9X3ZLcIGKTYcMIIlzdF4l2SsqCiae30c=;
        b=lIwJhTIJeqqmTZs9jPyXL4p6JsscORmV1/tHk92KMmMHskxYWcF5PwHoYOAAHzjB+M
         xUOOs7o8mcvsh7uiW0PP/Yc7eUSdjruL3kCp/X8Nf5wzCUqkyZlZVFzXuwY30YICC5Ee
         x3rouQXYD51ShVHJmL1GWcGyZr2Ca5WeQUeWqPt3I5Tc7NEAiRsuFbbPJJEfnlxl/LvL
         kZX3LCozZo0EtR5rGu0qWBx7Q9jwmL6oZ69/bQy/2vueaWrciB6fuRjKeLCOfXivF+ll
         d+fq7BAsRNikSZYUE2G/vwTZo39ISllXrjQdyGh1QsaZvzTIg/pEM9mwmNtw/F4MUU9l
         Ixtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687447003; x=1690039003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3ttuXOUR5H9X3ZLcIGKTYcMIIlzdF4l2SsqCiae30c=;
        b=DA/uEkBu4qws3NTtyXI+GwuCUXTCH50oQJSI+JdWzMrZNDPoEJ/v4aDoWqPBFhZzTn
         hDNuYqkMYgpz3FViNV34EMt6OmM66UWZbWrJXMHFSEk5DUnv6WJjjaqIIR3BUFSxawF4
         t6pznI5ycKL4QiQa6ceQ9j0Rdytm9l18p+ty/1qdFXnCukOXTmG0/mET+SjbMSYy8+1P
         c0ucXY5TvTAPyieH0Ejd5Hx8a+LJazWAGw8XD0qLGXLf/5QhA4QaxSs/cEZYyrDDsTAw
         TkDe4Su5HkO6eM7ErRZV8neVsPdy3+QS+2CoGyDu/US7i6teDKzuloIfPdEGzoJoW+1Q
         xY4g==
X-Gm-Message-State: AC+VfDxs0n3pXJuUi/IyMHLzo8MIp8CtSa4AgHsAtHAKbBdjB/QH0Bja
        jaQh5aeHhb8FNK620eSlqw+WCdxcYVqmZVKT+dM=
X-Google-Smtp-Source: ACHHUZ5NdCaz7HtUNii0ww2getN4EvfbVhp5TU02LZT2g2hzj5cDBCA3qk1ExWD2NS3fDAIXfvvIqg==
X-Received: by 2002:a19:5e47:0:b0:4f3:b708:f554 with SMTP id z7-20020a195e47000000b004f3b708f554mr10411687lfi.47.1687447003629;
        Thu, 22 Jun 2023 08:16:43 -0700 (PDT)
Received: from [192.168.16.142] (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id t27-20020ac2549b000000b004f76388c0a6sm1141194lfk.236.2023.06.22.08.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 08:16:43 -0700 (PDT)
Message-ID: <e651886e-28a7-d98d-adeb-732adf66bad9@kvaser.com>
Date:   Thu, 22 Jun 2023 17:16:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 0/3] can: kvaser_pciefd: Add support for new Kvaser PCI
 Express devices
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>
References: <20230523094354.83792-1-extja@kvaser.com>
 <20230523094354.83792-14-extja@kvaser.com>
Content-Language: en-US
From:   Jimmy Assarsson <extja@kvaser.com>
In-Reply-To: <20230523094354.83792-14-extja@kvaser.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 5/23/23 11:43, Jimmy Assarsson wrote:
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
> 
> Jimmy Assarsson (3):
>    can: kvaser_pciefd: Move hardware specific constants and functions
>      into a driver_data struct
>    can: kvaser_pciefd: Add support for new Kvaser pciefd devices
>    can: kvaser_pciefd: Wrap register read and writes with macros
> 
>   drivers/net/can/Kconfig         |   5 +
>   drivers/net/can/kvaser_pciefd.c | 678 ++++++++++++++++++++++----------
>   2 files changed, 479 insertions(+), 204 deletions(-)

Sent v2 of this series
https://lore.kernel.org/linux-can/20230622151153.294844-1-extja@kvaser.com/
