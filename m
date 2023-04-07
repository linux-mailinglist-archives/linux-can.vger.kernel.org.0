Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5216DB2F2
	for <lists+linux-can@lfdr.de>; Fri,  7 Apr 2023 20:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjDGSlE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 7 Apr 2023 14:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjDGSlC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 7 Apr 2023 14:41:02 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F56BB92
        for <linux-can@vger.kernel.org>; Fri,  7 Apr 2023 11:41:01 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id ix20so40668908plb.3
        for <linux-can@vger.kernel.org>; Fri, 07 Apr 2023 11:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680892860;
        h=fro:content-disposition:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kxr1xMxqf5mfDQTUmjqF4Od1A6dI7UcJsri67WdujmQ=;
        b=UCzTj4DQFhPUFswbbN0gBvsRw2wT2xYE2ds0lekwKUhpreGnYLCZF8OhEkf0EFsr1g
         uhchv67lu0VP3ym0l/gHAf935JgWEG0lgkE9RvIHVoJ1xiIcST186DXqNcg50Q7fNyrd
         S6x+l1Elg38rmJIeYX9tZCAxpHMhYPj2HI0FPYxAkdQPLRdC6MSN+LlNIUHdh4U++yMP
         QSprN3cyKOQrPtaAN6B578DNor72r5DX7ajuzSwv8ueU/uZEPDV6TA9SAEYBT2KJvvkF
         MFrK3GJIfqU/G3RKJyFapc9Hokhi8okGGfG8yhR8PljQY5dMJmJnuckPcasRsUOEUzQ0
         Qvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680892860;
        h=fro:content-disposition:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kxr1xMxqf5mfDQTUmjqF4Od1A6dI7UcJsri67WdujmQ=;
        b=zIWBLvrwkV7Ck39MO+GzqCgXDDjL/F7suB5ywSBQF5OsMIx2pvZfWb4hkT2SmsW6bw
         94Hd+HlmdEtpWMUIGs+2F2QW3OX5tzTydiDr5GSJD+9sCUWNim4rTiykIOdaWdwb8YEX
         T8JWkPhCrSw4KSmhRR7JGpUYeShuGsCyIa4BKJsRoLDUA4moBnG872yWe6WGFEwEhfBM
         PWRzmVFJo4wu14bPUyA6m1NeLGwNT3lCxMvznJnLQzEfimIkaTfk9Z0KaR3IDGB3Q5sV
         mpbJSzcqWa9nzRmregtOAX/4A6Gjk8gfvF4SdchHhUsxve0yaKrfnk37n0eIjBxsGl+U
         +awQ==
X-Gm-Message-State: AAQBX9eraWxk8ZnG1xSC0eCi+TgkLqfSwYqwA11NqX8iUg9BTqotCGln
        Z5T0OEUQz4rJTQspayyDIi2cF5i6e54=
X-Google-Smtp-Source: AKy350apBG093aFrCEBHfBCw1Ld4lcxQrIAR5V4xpcWyYz8avm2r28K5DmBwTaFmSSOkLNHXO0DolQ==
X-Received: by 2002:a17:90b:4d04:b0:23d:e0c1:8b93 with SMTP id mw4-20020a17090b4d0400b0023de0c18b93mr3404066pjb.34.1680892860322;
        Fri, 07 Apr 2023 11:41:00 -0700 (PDT)
Received: from inky-cap.rainforest.net (c-174-61-184-193.hsd1.wa.comcast.net. [174.61.184.193])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090a86c800b0022335f1dae2sm684717pjv.22.2023.04.07.11.40.59
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 11:40:59 -0700 (PDT)
Date:   Fri, 7 Apr 2023 11:40:58 -0700
From:   quinton.cook@gmail.com
To:     linux-can@vger.kernel.org
Subject: J1939-22 implementation proposal
Message-ID: <ZDBip6w2rz67G996@inky-cap.rainforest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Fro:    Quinton Cook <quinton.cook@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

J1939-22 (-22) is a new recommended best practice from the SAE. Below is my proposal for the bare minimum needed to get a -22 implementation off the ground. Each sub section focuses on a particular feature that will need to be added.

Stated goals of -22
- Take better advantage of the increased bandwidth capabilities of CANFD
- Ensure as much backwards compatibility with J1939-21 (-21) so that rewrites to existing applications are kept to a minimum.

Major changes from -21
- Except in certain cases, you are not allowed to send classic can frames on a -22 network
- Parameter groups that total less than 60 bytes will be packed together in a new CAN FD frame called a multipg. Multiple parameter groups are to be sent in one multipg
- The transport protocol allows for up to 4 simultaneous BAM sessions per network to be active at once, as well as 8 simultaneous RTS/CTS sessions per application.
- Large emphasis on assurance data for functional safety and cyber security

1) Kernel implementation of multipg service:
The method I propose for implementing the multipg service is as follows. A cyclic task within the kernel runs every 10ms. When the task is running it checks a send queue for each source address registered within the kernel. For each parameter group within the send queue a multipg is constructed from the contents of the queue and transmitted.

2) Sending assurance data 
-22 provides a very clear format for where assurance data should go within a message. As a result, I believe it is the responsibility of the kernel to handle the packaging of assurance data on behalf of the application. When sending a message, applications have the option to include either 32bits or 64bits of assurance data for each parameter group. BAM and RTS/CTS messages can include assurance data as well, but the length in that case can be up to 52 bytes.

I am open to ideas for how to pass this assurance data to the kernel, but I believe it needs to be separate from the data bytes that are written to the socket. One idea I have considered is expanding the sockaddr_can.can_addr.j1939 struct to include a pointer to the assurance data bytes as well as a length for the assurance data bytes. 

3) BAM
Handling BAM messages is straightforward. The kernel will need to keep track of which source addresses are currently executing a BAM transfer. There is a maximum of 4 simultaneous BAM transfers allowed on a network. The kernel will need to issue an error to applications that attempt to start a BAM while there are 4 active transfers going on.

4) RTS/CTS
These become a little trickier with -22 mostly since assurance data can be bundled with and RTS/CTS message. The kernel needs to be able to pass the data bytes to the receiving application. The application will then need to process the received payload and ensure that the received payload matches the supplied assurance data. At which point the application should give the OK to the sender and the session can be closed. It would be nice if the receiving application could supply a callback function to the kernel so that once the message was received the kernel could execute the callback function, verify the data bytes, and then acknowledge or abort the connection.

5) Simultaneous BAM and RTS/CTS handling
Under the new scheme it is possible that a particular application on the network can be transmitting a BAM request as well as an RTS/CTS message at the same time. To avoid mixing up messages from the two transfer sessions the kernel will need to keep track of the: source address, destination address, and session number for each established transport protocol sessions.
