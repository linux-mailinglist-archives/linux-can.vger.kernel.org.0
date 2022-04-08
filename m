Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E60A4F9353
	for <lists+linux-can@lfdr.de>; Fri,  8 Apr 2022 12:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiDHKxQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 8 Apr 2022 06:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiDHKxP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Apr 2022 06:53:15 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DA31E015F
        for <linux-can@vger.kernel.org>; Fri,  8 Apr 2022 03:51:10 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a30so10873842ljq.13
        for <linux-can@vger.kernel.org>; Fri, 08 Apr 2022 03:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=TDRBRo6JLkIP18+GWzw8c1nzqM3UaGADeZvtQ3nUW5o=;
        b=JIUcsLhP/WTpsPbAKcOYseod+oaShWFZAk1nKhP7GNbCYdLac+bFxTAc1hrznK80yT
         EqlIDWitACbCGxJ0w1lgX81gx+9TJ+/uMx+F60kiIwl/sthkm05LJ6wg17aX/hzFN276
         t3W26yaeEipEIMJLeC9ybU0SbLydL5y1ORGLDrJIPY4RNXOKreVdffJSwEN9kyL2tbVQ
         Nnbg21ktF0+D36AqVfKK+HMMASsqbNmYZxS3AcLT9ofMeJmiS7OvyPlKPVlx1Tqhj5tq
         baFXOsCHQ0VY4HlztDe+xoz1HYrB66hSVTIxTT0S8wtZSEaH28EA304QZpGVSZm2a1O4
         kSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=TDRBRo6JLkIP18+GWzw8c1nzqM3UaGADeZvtQ3nUW5o=;
        b=z2oMHFKZ4QiY8qjhYGrQ2stWcn3Nmr5epk9QzaKLyc84tSshSpqrl7cME28vHXQwQv
         zPvE/2IgdU0RhDXS4QqG1UqBJC0U23qgR+Q8c30dHFaGb/hcgKMJpcCxHe2aY0RZFtkw
         2Vj6+FWeVtzYaEYNKwgHuyqqJ7vrK6HswmqC5wuvR3gDhMurZ34QpJBCPtvneuTKEAJf
         dMuIlce+mq2w3oBu4jw9tp/XqMgd0dkKQbBKXeQTMeHKacrwHCL0U/m0k8WC6b3SitDr
         qHzTK7KPdmjF16+a0Us+7MyX7jmXMqP0PtLt7eh5tTNlFkeeiHfBm5Mg1hfFVPjFyu86
         RLmg==
X-Gm-Message-State: AOAM532W9SxyUVfOy/XsRftGernUfFj1ypBgZS3jY3Icu2/Zv9c1XjsM
        ogBnLAKwC+qhyhnk6T7NknJiRuIGR41726jRxfQ=
X-Google-Smtp-Source: ABdhPJytEmetflcdBt2bncFSNeOA524VIIbaRhhgfnkQNYMGw+u3fOA/72+JXoAkOVgLmTiw8zFfGFlTGKUDGWNE4m0=
X-Received: by 2002:a05:651c:158e:b0:248:1ce:a2a with SMTP id
 h14-20020a05651c158e00b0024801ce0a2amr10869245ljq.172.1649415068275; Fri, 08
 Apr 2022 03:51:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:2241:0:0:0:0:0 with HTTP; Fri, 8 Apr 2022 03:51:07 -0700 (PDT)
Reply-To: sj7373313@gmail.com
From:   Sandra Johnson <issaikpindi@gmail.com>
Date:   Fri, 8 Apr 2022 10:51:07 +0000
Message-ID: <CABpBKQb+97zDwSS+-SBG8OJs3ERYoSJu8QkJqG+ttU=D=iL0GQ@mail.gmail.com>
Subject: Sandra
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:242 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [sj7373313[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [issaikpindi[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

HI,
Good day.
Kindly confirm to me if this is your correct email Address and get
back to me for our interest.
Sincerely,
Sandra Johnson


HALLO,
Sch=C3=B6nen Tag.
Bitte best=C3=A4tigen Sie mir, ob dies Ihre richtige E-Mail-Adresse ist,
und melden Sie sich wegen unseres Interesses bei mir.
Aufrichtig,
Sandra Johnson
