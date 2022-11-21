Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3167D63290F
	for <lists+linux-can@lfdr.de>; Mon, 21 Nov 2022 17:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiKUQLk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 21 Nov 2022 11:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKUQLj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Nov 2022 11:11:39 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EACCB942
        for <linux-can@vger.kernel.org>; Mon, 21 Nov 2022 08:11:38 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id f18so29710848ejz.5
        for <linux-can@vger.kernel.org>; Mon, 21 Nov 2022 08:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=01ifG+pc+vCTSdwSID6c6icJNdj2A1gFCwhKSniOp8E=;
        b=AeEapRqvfrvCWqxVLNYG0DjWedQFnbO4DEOZk+uM+jvAsO4WWqyU5u4rf0eKz5FS1k
         zI4ZHJStMn0uEF5I1ai2P1r2Lw9hQrBNjukyIrNkGSb+Y0pMBwyy/uafPYRuDf0lLA1c
         amYSgcDQgdjf4yG+Xj/6Gk4tcrUQyCQyqrPqfaSCyswRrTHIE0vNDvNOY+ba80Fsa1P6
         ycIgM27iQsij61HfRBYwp1cY+9nw7IVX9pNktn0hv3pO8FfOv0A1Idcb7WmDG3xW1KBX
         QozEz9z7sKOBP30Y4uDW7jDfPLwNiFiif0W+Hhvp/vD4iHaXmSL2fZjb3/S+MVQVs7Mf
         Z18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=01ifG+pc+vCTSdwSID6c6icJNdj2A1gFCwhKSniOp8E=;
        b=Y+AcK7tk3ctt2ZBL+Qbq2+4OVw1mORibxIaJ2ji84gJJeE/FDHSjY28JOUIsiHqycH
         VDl0bc1S9mhLhkSrmH7Cj5aT1BW9/Y+UoR1GBlW8jBJ2+zgCB5HU2HSj2wqnHs01dw20
         SoiG94dqcb/rvrIof7vQg5kvrdrABLk+poDyPaIOlXr+DpmPQswy4xUaI5ps6L/Bvagl
         +fZ6VHz7ds5PD4Cb/P0/cM9+IceZk5inoT6f8dNoobFMSzj6YW5X53Q4hxCZG+6qO8tV
         WT3MHPR3FDL28UDwJ2IxXcGC0GteOxmDeS4v0y6bCy3EdegC6jrCnIC9XdcKC7pFfDMV
         5vOw==
X-Gm-Message-State: ANoB5pnNTwj8+2ny80jeZnqT5Q0y7KTzwRpUtE4K3P6kOLDEC6wQmKiN
        j221zgvosAiuhmyCALn6qaUBhbcVovo=
X-Google-Smtp-Source: AA0mqf44MywsljcxHpxWnVFnCu9QLa7COaAJ/ke8RPjCF23edA09Lv8JcorhukRtEeBdb8w0FicVXQ==
X-Received: by 2002:a17:906:6d8e:b0:7ad:a2e9:a48c with SMTP id h14-20020a1709066d8e00b007ada2e9a48cmr4503736ejt.77.1669047097147;
        Mon, 21 Nov 2022 08:11:37 -0800 (PST)
Received: from ?IPV6:2a02:810d:d40:2317:2ef0:5dff:fe0a:a2d5? ([2a02:810d:d40:2317:2ef0:5dff:fe0a:a2d5])
        by smtp.gmail.com with ESMTPSA id up30-20020a170907cc9e00b007ae0fde7a9asm5125723ejc.201.2022.11.21.08.11.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 08:11:36 -0800 (PST)
Message-ID: <49ce15b4-feaf-a519-9172-d0f59a9285ed@gmail.com>
Date:   Mon, 21 Nov 2022 17:11:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: Problem receiving > 8 byte UDS response when using istpsend
To:     Marvin Ludersdorfer <marvin.ludersdorfer@dintec.solutions>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <FR2P281MB165556E4F729AC3CDB50F6F69F0A9@FR2P281MB1655.DEUP281.PROD.OUTLOOK.COM>
 <FR2P281MB165503FACCD9894C353ED4CE9F0A9@FR2P281MB1655.DEUP281.PROD.OUTLOOK.COM>
Content-Language: en-US
From:   Andre Naujoks <nautsch2@gmail.com>
In-Reply-To: <FR2P281MB165503FACCD9894C353ED4CE9F0A9@FR2P281MB1655.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Am 21.11.22 um 13:08 schrieb Marvin Ludersdorfer:
> Hi,
> 
> I'm experiencing problems when trying to read out ECU parameters using istpsend when the response exceeds 8 bytes:
> 
> In one terminal, I run isotpdump -s 00000680 -d 00000780 -c -ta can0

Use isotprecv instead of isotpdump. isotpsend just sends the 3 bytes, 
you pass to it and then is done.

The FC should then be sent by the socket, which is opened by isotprecv.

E.g.
terminal 1: isotprecv -s 00000680 -d 00000780 vcan0  <anything else>
terminal 2: echo 22 f1 95 | isotpsend -s 00000680 -d 00000780 vcan0 
<anything else>

... your milage may vary though.

Regards
   Andre

> 
> In another terminal, I run echo 22 F1 95 | isotpsend -s 00000680 -d 00000780 can0 -p 0x00
> 
> In the first terminal, I receive only the FF, but no FC frame is sent (expected is a 11-byte response).
> 
> If I turn around the communication direction and run isotpsend -s 00000680 -d 0000780 can0 -D 255, the target ECU answers correctly by sending the expected FC frame.
> 
> 
> I would expect that isotpsend takes care of sending the FC frame in the first example as well to receive the full response - am I doing something wrong?
> 
> Any help would be highly appreciated!
> 
> Best regards,
> 
> Marvin Ludersdorfer
> 

