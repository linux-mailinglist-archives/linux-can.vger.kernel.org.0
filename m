Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1BB54DEF3
	for <lists+linux-can@lfdr.de>; Thu, 16 Jun 2022 12:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376475AbiFPKZ3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 16 Jun 2022 06:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359495AbiFPKZZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 16 Jun 2022 06:25:25 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797C25DA28
        for <linux-can@vger.kernel.org>; Thu, 16 Jun 2022 03:25:19 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id h23so1523644lfe.4
        for <linux-can@vger.kernel.org>; Thu, 16 Jun 2022 03:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=lLG88JCPgF7Yhflf4FNi4GQedsSNMbwmPtgneUr9Mu0=;
        b=W910NhxhsjMJh8xmTqiBb+n/d8vNhkQvEK3uQsx019H/NVF/HsRkR91Mwgf5NoOA2o
         +G9NG8HKS3dufLn4HoWATUwViMwR/sm7gdhYVGjSBp65IoH9/VzeePSRwsxtnWyD2IYd
         /P+anhEIznyuyfYSv0fd8QvDY0LuzCx2TbyvmZF5dM2Nj4uA7+9FyoHxvD1xuHmQyiMU
         TCzjnL3q1oIV583xyWy0s+D4KRyb2LgtwArAnNeV+m1AO8ORaxA26nm4VB9kA/9NXW1T
         yHcu0NzK0YGRQb2+53awbQan+6daAbhIX2qCkYqY9Qavm2WmKJIEIH3npl/ZhVNAwvQV
         qPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=lLG88JCPgF7Yhflf4FNi4GQedsSNMbwmPtgneUr9Mu0=;
        b=KzJxFsolAyJY9xTHuioqzNKe7lf2UqPl4wfEitR9usHrQ2JlVfYJgR/JxykVCHoxxR
         ccH4PvWTWcT2UDEbeONaY19c1v5Ir4L7p5w9xtt/MLhcnbcgkf7l4h1KUBkYRNqbUlhc
         mx51mFiBM7dlpY3BbO03LDYrmx7BkbqdOHtgIYQEFM8HVITSmfCfD+UXEXlmzWxdS/fw
         USDb6wVzeB1fkiuzq1Xa6iPZxrvBu5pMmQaCzKz0sN4T5H7GY7AdkTdXqCmwoeSaVlnr
         weBvWXaVk8h3GCsUmMC+z8u4jXC4zV50tXEZwEbdZKmzpr16OkjvAtzHN7Luq1YJldgD
         UcJA==
X-Gm-Message-State: AJIora/LN4CIXJ7TtO7HV4kg+CgSKA/si1erfgMn9/JEwHv18eAf5oeL
        7ej8RO1tcRhC85+2++CONIyK6Gvw/pUWru3YOGY=
X-Google-Smtp-Source: AGRyM1v2MTXGyROmKEYPPr3IJqOTubJyWU9u6UFQYhvDngD40bhPycsNsVME02FGDV5945mXaS61m+8B4cqbLiC7v1U=
X-Received: by 2002:a05:6512:3448:b0:479:10f0:11c7 with SMTP id
 j8-20020a056512344800b0047910f011c7mr2248569lfr.521.1655375117521; Thu, 16
 Jun 2022 03:25:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:28c2:b0:1f3:cf5:e20d with HTTP; Thu, 16 Jun 2022
 03:25:16 -0700 (PDT)
Reply-To: clmloans9@gmail.com
From:   MR ANTHONY EDWARD <bashirusman02021@gmail.com>
Date:   Thu, 16 Jun 2022 11:25:16 +0100
Message-ID: <CAGOBX5aJ01nW_foH2aLY6UF6s28QePJ4_J3aCt=hjQSuJNsdog@mail.gmail.com>
Subject: DARLEHENSANGEBOT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

--=20
Ben=C3=B6tigen Sie ein Gesch=C3=A4ftsdarlehen oder ein Darlehen jeglicher A=
rt?
Wenn ja, kontaktieren Sie uns

*Vollst=C3=A4ndiger Name:
* Ben=C3=B6tigte Menge:
*Leihdauer:
*Mobiltelefon:
*Land:
