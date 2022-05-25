Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FD253454A
	for <lists+linux-can@lfdr.de>; Wed, 25 May 2022 22:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241014AbiEYUsd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 25 May 2022 16:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240028AbiEYUs0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 25 May 2022 16:48:26 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CC8B82F6
        for <linux-can@vger.kernel.org>; Wed, 25 May 2022 13:48:23 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id i187so36043626ybg.6
        for <linux-can@vger.kernel.org>; Wed, 25 May 2022 13:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=+uyh4vUIYntN7Mid2B5fbgguOxBR2RiHnKBh7A4r37I=;
        b=MIznAoP29XHGMZwK2XaORcuFYY4KHU3SiD37YZr3IksbwEszYFwRGI6NMOaIsgw3Rc
         MNWUak9e2Pk5zm0JPp6szTBpWptBOFEsDKaXw1mzZOTFcRGcvyjOwqdtF8UB9EvyuuJZ
         fMICjT1+KZ7bxeE9NTTU8LESXRGeqFThSri55TjzyU4r+qSYB8KRkbeHsWYNf08X2bEy
         pryupL2ykuBV+sygnkk+fqajrVN1/45XJT6UIDBI/J4JIiO7GZW4kaISjbo9xtOnIbu3
         /lAT2wlHOnLDqj2MsvwscUqPgxRkbuhwflLse0VSR01xDxZYapbGb527uMRlqnyfWWDn
         3l8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=+uyh4vUIYntN7Mid2B5fbgguOxBR2RiHnKBh7A4r37I=;
        b=BGc25Tc2rSbnSEN/NzZnZSJuPiJUInW6QFR/MIuuzn8QxOoP83IXDy2vztfufFU0ou
         bBNog9dJmQo94It4lC2moJ3YyVR6bOcYK5PCeea2J1Ki80SKJxai3j7uWtoJb82QJjLx
         rf2gkQAJnt8SD5tvWtc4ZbDNvG3kbI5+NPUCUpROwm/M92adjpy3UKPSHdhFA1U4NO8s
         X/3HbmkOZagnXqc1eA73rWhu/l8SaAdCo+m93hDgQK5/za/jJnHOKvEy5dGT6BfUhVhQ
         ym658Q9P28e7Ckvy3TqhxsO/rXSE28hSeXKQhpjaRqQXx9V3oF0on2CLUuocvJcbV2yw
         OtuA==
X-Gm-Message-State: AOAM530KUnP6HTwRfXLEIwGuZhQ6ruGKyeuSwfK9gAowq6HwowAbpv8k
        jcJUavBN4hn4pvc+ys/RsH4biaakU6qb010GZtI=
X-Google-Smtp-Source: ABdhPJygDnPWuNyLLxTk2B3Kv8LEKih1+m2wVtTUpsrNi1Bs8nM6GPylqvWzkD99kDlHZJJaie6GrPKCBIwCtXokpK8=
X-Received: by 2002:a05:6902:1023:b0:64f:39e7:ef05 with SMTP id
 x3-20020a056902102300b0064f39e7ef05mr31533397ybt.126.1653511701867; Wed, 25
 May 2022 13:48:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:3682:b0:17b:2b7b:c035 with HTTP; Wed, 25 May 2022
 13:48:21 -0700 (PDT)
From:   Colina Fernando <colinafernando724@gmail.com>
Date:   Wed, 25 May 2022 22:48:21 +0200
Message-ID: <CAP7Hh1-EL6tqrQsO0De_QJ1avJao_roXNeVStyzCoPtO9q14fg@mail.gmail.com>
Subject: Bitte kontaktaufnahme Erforderlich !!! Please Contact Required !!!
To:     contact@firstdiamondbk.com
Cc:     info@firstdiamondbk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Guten Tag,

Ich habe mich nur gefragt, ob Sie meine vorherige E-Mail bekommen

haben ?

Ich habe versucht, Sie per E-Mail zu erreichen.

Kommen Sie bitte schnell zu mir zur=C3=BCck, es ist sehr wichtig.

Danke

Fernando Colina

colinafernando724@gmail.com




----------------------------------




Good Afternoon,

I was just wondering if you got my Previous E-mail
have ?

I tried to reach you by E-mail.

Please come back to me quickly, it is very Important.

Thanks

Fernando Colina

colinafernando724@gmail.com
