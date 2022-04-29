Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD250515138
	for <lists+linux-can@lfdr.de>; Fri, 29 Apr 2022 19:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbiD2RDf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 29 Apr 2022 13:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358853AbiD2RDe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 29 Apr 2022 13:03:34 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A79E7B
        for <linux-can@vger.kernel.org>; Fri, 29 Apr 2022 10:00:15 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d5so11566695wrb.6
        for <linux-can@vger.kernel.org>; Fri, 29 Apr 2022 10:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mmd4qjxvG29M6kC9w1keSuqoCPTvZCriqLVPrV/8mEU=;
        b=p57to1OO8IDbyWFv50NYpmqt8eP5m08L0VrvbQzUYPTF+PWbvx2POSk2ZJ33/5650q
         L/VuOkNJlChXOBbjUlbiMDeWc7Gf650wJ1ykafapFPDF+Ke6TVUnhj5zyFS5NKkOrG7e
         5OMP165NY6+CAcljdBFIv4VjE0Bry+351Sjk8TvCHo/1D8XikIa3uCis9+ueNM+A2EUY
         nUi0iZ8zOmQryq56SqEbanxb7FT32SW6dPxgVySeybyH7jYInVi7C8MdKzPdEPoe4FI1
         Fw/KQh8iRyiKGF/3Qd7YEv+8jFEJRePTsND6JExrriuiTP8js/jHSLP+asPGh1Almd/3
         aFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=mmd4qjxvG29M6kC9w1keSuqoCPTvZCriqLVPrV/8mEU=;
        b=cpCorQnRxVZcheHO2wWXyvbvEPeYT8hV3e5HcY12dyL0xtjb6SinAveuf1SU5CzwIm
         X+ZO4b2L2J/beDrl/573vpvC+T+7l/hrcvd/CvoOVkknVAum81Cg7whpSsd5IzlEC4bV
         ufqyrN3O70zgKJmyMkdtwOGzZ1P4TXpJRKMgUeyPUwiIIYFTsD9x0r7Kq+6qF04ZyvG+
         42cjBnlJM3yru4yfl/srphNf7mth4x6+h/xM1gUDgcHw28STawSGrpXdm6jJI9xgUV5h
         yasVIUFAsrKxo8A6uG0IaA/vzzBKv8ULZa1Bi5ptdF+pbUWEvMnRfwMjx/TF55XJfaDF
         3B5w==
X-Gm-Message-State: AOAM530ZS9Rl0gTn7wSo8p1Id5f30ZW2tCtwEUvEPYkX2mfPEDbH9dR2
        o3Qmf3ZSDjdYdQHyvQ7sHbagO4Pbx0HmD8UgUgw=
X-Google-Smtp-Source: ABdhPJxfVv/9zA2PG2KSIeN88uv/rLLnko7kv7VdklauUrEEW/h3VEY+PBzL9M7BUMwoXkmy/RDd0gMfyaalXUWbcCA=
X-Received: by 2002:adf:dc0f:0:b0:207:9980:5de8 with SMTP id
 t15-20020adfdc0f000000b0020799805de8mr68098wri.300.1651251613719; Fri, 29 Apr
 2022 10:00:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6000:1a88:0:0:0:0 with HTTP; Fri, 29 Apr 2022 10:00:12
 -0700 (PDT)
Reply-To: gb528796@gmail.com
From:   george brown <ed7293954@gmail.com>
Date:   Fri, 29 Apr 2022 19:00:12 +0200
Message-ID: <CAN9EptLgue0yCsLxvjisngRnsprQSQCpfQRZ-UB-qQxzv-DrVw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,REPTO_419_FRAUD_GM,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:42c listed in]
        [list.dnswl.org]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  3.0 REPTO_419_FRAUD_GM Reply-To is known advance fee fraud
        *      collector mailbox
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ed7293954[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ed7293954[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [gb528796[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Ahoj

Jmenuji se George Brown, povol=C3=A1n=C3=ADm jsem pr=C3=A1vn=C3=ADk. Chci v=
=C3=A1m nab=C3=ADdnout
nejbli=C5=BE=C5=A1=C3=AD p=C5=99=C3=ADbuzn=C3=BD m=C3=A9ho klienta. Zd=C4=
=9Bd=C3=ADte =C4=8D=C3=A1stku (8,5 milionu $)
dolar=C5=AF, kter=C3=A9 m=C5=AFj klient nechal v bance p=C5=99ed svou smrt=
=C3=AD.

M=C5=AFj klient je ob=C4=8Dan va=C5=A1=C3=AD zem=C4=9B, kter=C3=BD zem=C5=
=99el p=C5=99i autonehod=C4=9B se svou =C5=BEenou
a jedin=C3=BD syn. Budu m=C3=ADt n=C3=A1rok na 50 % z celkov=C3=A9ho fondu,=
 zat=C3=ADmco 50 % ano
b=C3=BDt pro tebe.
Pro v=C3=ADce informac=C3=AD pros=C3=ADm kontaktujte m=C5=AFj soukrom=C3=BD=
 e-mail zde:gb528796@gmail.com

P=C5=99edem d=C4=9Bkuji,
pane George Brown,
