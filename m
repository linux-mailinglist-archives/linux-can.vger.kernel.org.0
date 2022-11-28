Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F176863A628
	for <lists+linux-can@lfdr.de>; Mon, 28 Nov 2022 11:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiK1KeA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 28 Nov 2022 05:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiK1Kdi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Nov 2022 05:33:38 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135761ADBF
        for <linux-can@vger.kernel.org>; Mon, 28 Nov 2022 02:33:32 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id n9so381945uao.13
        for <linux-can@vger.kernel.org>; Mon, 28 Nov 2022 02:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFV+j+1TLtUL/wbZKnobmQuBkAthMS/vMODiYSi4VWQ=;
        b=dN0S/TpVo17Z4AnM/TuuJaCe98CuqanwOg5YHhJKFqDRe/XXHVEJsjoISyq1Cmqx1j
         0uBLi5k2KYgKLb0wJN/8nJMKKC+QfAoQMBUXlp2twX/+qKIPRcED3KeU8t5ehnzJFS8T
         65TGWtyTWNeKESVAV5k2Jq8+UbUBXufpB3EU0Q/KtwpV+2ospxwEbNgud4LgaQwoYPey
         U9Ic8CybTRvL7HXiy/aZ4Uq3ljQIVGFP29Etd4oyUghXDNW7Hu4mQnhcWAgztWv/eah+
         mY/j/CvhNH+RCzVLZwBf/PLZqJpBKhX9wvmc8it2YhsMYfHMSiuTDN3QWe5hGOQLRL7Q
         lJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JFV+j+1TLtUL/wbZKnobmQuBkAthMS/vMODiYSi4VWQ=;
        b=YPFdr0aKqg1J3mAmsFvHdN9kASBBgQ9K0paFdxS38qojiiUuVI3fjPIQ6HMthu2Gzw
         OePRLd0hpjDoQou7YtAfhGgZnKEg2g22qaRddZDmSK8QyinG2UUucvnQ0X43TgT1tDJG
         ZzfHGAajnauiA39oYNBi5ASmcsJrzzPDig7mfupQ6q4rdlkaucHzZJQmqdwr1vVFHY2y
         NX+XvFc1Tx1TknBAUdCARdFNoDK923K2/YJDMkgSbFWmZliwp4FDpLsU5OPBHEg3Uchb
         97oJZyB967SjmjIklKWompa3kWMIXmFRmV8idxz8eHwNAJdKXte3QYHPzRjGzBJ5+C+G
         CDFw==
X-Gm-Message-State: ANoB5plPX7Jy9OJQMK61ZT3sd0s+HMT2FkhxaYyoL3BuTJ57UjXCGzmX
        7MaMKyl3rhQX2vcWWol9YAuVqPDi+DSBrgjH4Sw=
X-Google-Smtp-Source: AA0mqf4b8T+FeAOE8Bo4igruw+OZCvIu8xtSfd4uYD/tTavKK1ginA1t4eiN7UHcz3azfmiwSNHAhXhkqn+zJSTyc5A=
X-Received: by 2002:ab0:298e:0:b0:419:27e4:c2b9 with SMTP id
 u14-20020ab0298e000000b0041927e4c2b9mr416176uap.118.1669631611164; Mon, 28
 Nov 2022 02:33:31 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a59:dc91:0:b0:32b:a013:5722 with HTTP; Mon, 28 Nov 2022
 02:33:30 -0800 (PST)
Reply-To: erickkofa@yahoo.com
From:   "Erick Koffa." <koffamorris8@gmail.com>
Date:   Mon, 28 Nov 2022 11:33:30 +0100
Message-ID: <CABirKWt9t3zBC7GeQJezLVXUvYi+MEYPfxWBi0GfXQ2kR1fX=Q@mail.gmail.com>
Subject: Re:
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Greetings from Mr.Erick Koffa, can i talk to you, very important please?
(erickkofa@yahoo.com)
