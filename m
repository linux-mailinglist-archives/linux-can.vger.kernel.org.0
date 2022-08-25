Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F6A5A11FE
	for <lists+linux-can@lfdr.de>; Thu, 25 Aug 2022 15:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241413AbiHYNZc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 25 Aug 2022 09:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242497AbiHYNZV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 25 Aug 2022 09:25:21 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB46395E75
        for <linux-can@vger.kernel.org>; Thu, 25 Aug 2022 06:25:19 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z6so28213937lfu.9
        for <linux-can@vger.kernel.org>; Thu, 25 Aug 2022 06:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=na57S2vRNcuynquJMcsrRydi8FqM+CTHWqPG/CUMRQQ=;
        b=cJvMzSP5TAu5rSiQAwXwpcS4zs+KciFKS+6V/+Kdka2qAdujnSzPtIYzWz9P2mchv3
         nHk0Z4ofCND9qGzUm6LHbp4JAcw/+dh51vM6f/xhc9dYtin7Uh2qE0EuB8WBm+5oMgJO
         Bn1ZF9Nt0rMonhDghmPin1kTOXPgr084T9Kcp7vU+hQfFTQUgZBCwQRCzf493ccyuD0X
         YE03yxEUd3jAlyQZKKjF4lOTevc7LxqAaOThIspXtkIZxhEJEfxcTHiidFtrRNSp6uUM
         pjIMFJCvn0bLo1J7NRzQLQFyJQChyJJbkCVWQSbVTrPJ4MusUGnPoVL6dQ86gj4no4RB
         Dy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=na57S2vRNcuynquJMcsrRydi8FqM+CTHWqPG/CUMRQQ=;
        b=PsKJDAfmKSxXXoqDqjzt1Jcsqp9HTljxizAy2xtcvPLm9sFXohpw26WkMzuD1SrfgD
         9jo8fSpSlixRd7J2+C7NQmUU01ZpCHOp1pAUBA5XT/YDn0C8ydwYhkh2JAXYdvvEaPcm
         h2MR5nv3KMCI1oIaK1hGUvudvu3lKAomO9x3W02o0uIWI/MyjyWit6BgBGgD6D5rOJ6n
         aZTIuAKPnCE0EuIeZgyWoXgZf3GoYkAOoteyigy1r1G9rF5lAr8i9RnhLUtyQbwbuTuZ
         ENU9XLIG4/am/Kh53B2G8QyARq0q5+OIfktlP33BUxNTgxhzI+AdqsFQPBXs2ablhwzo
         P3Rg==
X-Gm-Message-State: ACgBeo1xIgSLhXKoB03E/fBW7DTqFs+Hz2Qgh7r+9gyXNR7rXzJrGrWW
        snzdvUtnVKQ2RA8Xq9dA/5OGdaLZMjA=
X-Google-Smtp-Source: AA6agR4qlrgv/JZvQdPLZHOAD8zccU9VzTx+weMgFiNBs4f7Q7PitmtBfI6I7csQapy6k9Qxj+efeQ==
X-Received: by 2002:a05:6512:acd:b0:492:b8e0:2ef4 with SMTP id n13-20020a0565120acd00b00492b8e02ef4mr1092813lfu.360.1661433918282;
        Thu, 25 Aug 2022 06:25:18 -0700 (PDT)
Received: from [192.168.10.102] (89-253-118-72.customers.ownit.se. [89.253.118.72])
        by smtp.gmail.com with ESMTPSA id a39-20020a2ebea7000000b00261cc85c32fsm566995ljr.31.2022.08.25.06.25.17
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 06:25:17 -0700 (PDT)
Message-ID: <15a8084b-9617-2da1-6704-d7e39d60643b@gmail.com>
Date:   Thu, 25 Aug 2022 15:25:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
To:     linux-can@vger.kernel.org
Content-Language: en-US
From:   Jacob Kroon <jacob.kroon@gmail.com>
Subject: CM-ITC, pch_can/c_can_pci, sendto() returning ENOBUFS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

I am using a CM-ITC board 
(https://www.compulab.com/products/computer-on-modules/cm-itc/) with an 
application that uses the CAN interface. After a while of successfully 
sending packets, sendto() starts returning ENOBUFS. I wait a whole 
second and try to send, several retries, but I get ENOBUFS every time. 
I'm using kernel 5.15.59, and I've tried both the pch_can and c_can_pci 
driver, but both show the same error.

In the console I see several of:
can0: can_put_echo_skb: BUG! echo_skb 0 is occupied

I've also tried to increase the txqueuelen to 1000, as suggested here

https://stackoverflow.com/questions/40424433/write-no-buffer-space-available-socket-can-linux-can

but I think that if I increase the queuelen the threads just block 
forever in sendto() (sockets are opened in blocking mode)

If I bring down the interface with

ifconfig can0 down
ifconfig can0 up

the transmitting does get unblocked.

Is there anything I can do to debug this further ? Any other ideas ?

Thanks,
Jacob
