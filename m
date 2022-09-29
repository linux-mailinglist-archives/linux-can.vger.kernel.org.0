Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E095EF388
	for <lists+linux-can@lfdr.de>; Thu, 29 Sep 2022 12:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbiI2KbS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 29 Sep 2022 06:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbiI2KbQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 29 Sep 2022 06:31:16 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B580812FF10
        for <linux-can@vger.kernel.org>; Thu, 29 Sep 2022 03:31:15 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id j188so1178591oih.0
        for <linux-can@vger.kernel.org>; Thu, 29 Sep 2022 03:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=2R9rezOeSZv7hb9r01mgXFWZD64uGjqRDhGdXAtulVg=;
        b=eyzo70bbcYPNNclLKrohdRZDmNh5YQzQU1nS5669wUjMKRsd2WBD1kTnGZ+VeZ1m/e
         vQRshfa7Y6FcHSxEiEiITL/U3ETvQ87KL/8/f+3rqYrRfIQ4SMtcxl2Tj6M47fmqdtPi
         Cmg+rbuUrDfEbhz+gtO7aMlRDanbrawUEiqGh3dynJChRqpROGQQLvNEZSCUbBbk5NSR
         P69uhrCau9hGovVqFGL1PZGTe+eTwUGIQeaPpjO7wEHumh3jkxLOBQIauaA6uNmMDZyJ
         QuYeoiRTrwzakIn1ySCkv/UrY41HJwKKl22tDZEdWwJ5b3auSIDzdNgAQ+837dSeLzFN
         wgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=2R9rezOeSZv7hb9r01mgXFWZD64uGjqRDhGdXAtulVg=;
        b=G9QcP43jw4iN/yMX+De70THwGQPY+8vhy0DT8ZlZFizTUHn9lk4fsNrCR0HqxWxGrO
         HSCjypPBtnzC220gRMkrbzhJjZjfCP8DQrtdWFk8FPbRCkDganFk6NRvO35kCLL+TzF5
         pq7Qw2j7Ce06SidsgS//lH0aDkSmqY4ddIwG/KF9y9ksEQUcOovtOCjtDWcI1FZzw6Aj
         6dmsNfAjsiLiH93F2syFkoXB+bEbMhiVN/NRrUt4zg/gXhotiG03+ruEaDeGKluo1E88
         whsVDos2popHTXjgC7kY2+ugwazEVr1SlE44l7oIxf42+hFwrcsjNpPiduvoiZei2QFf
         xmCQ==
X-Gm-Message-State: ACrzQf3vVaEUAwuC1eJ/You52usZHKwNlj5gWjjgYwzUGirre+vGDZnR
        pSe6bwE5cZR9sWkbcSgRk6b9n4xDFlYzODvr4k8=
X-Google-Smtp-Source: AMsMyM7BC4Fqvinl+T23s9BDIwDIn8+8gZD9heG3qE5vACSAsKzSKWfNBTRbw+XRHOoXfzLGlHPz0eTgzItq+8XgmnY=
X-Received: by 2002:a05:6808:23ca:b0:350:92c4:3422 with SMTP id
 bq10-20020a05680823ca00b0035092c43422mr1169764oib.144.1664447475041; Thu, 29
 Sep 2022 03:31:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:8407:b0:c8:de10:ec0f with HTTP; Thu, 29 Sep 2022
 03:31:14 -0700 (PDT)
From:   ulrica mica <umica1778@gmail.com>
Date:   Thu, 29 Sep 2022 03:31:14 -0700
Message-ID: <CAPuk59epyiK=MHwvmYV=zwj7njKc7f-4zzrkCDUPjBTofKMgJg@mail.gmail.com>
Subject: good morning
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

-- 
Hello dear
Can i talk to you please?
Ulrica.
