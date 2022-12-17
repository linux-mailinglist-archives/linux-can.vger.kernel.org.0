Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E642164FAF4
	for <lists+linux-can@lfdr.de>; Sat, 17 Dec 2022 17:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiLQQGX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 17 Dec 2022 11:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiLQQGR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 17 Dec 2022 11:06:17 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D233B636F
        for <linux-can@vger.kernel.org>; Sat, 17 Dec 2022 08:06:15 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id f20so5103175lja.4
        for <linux-can@vger.kernel.org>; Sat, 17 Dec 2022 08:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DgceQs6YATKdxHfCNYn6Tza2J5rBfHkY8t3odFqp3xM=;
        b=oHWC3bNktdQogZQNw9OVofUjDmp4fYe7wN+mejEeKc7F/bFmywp+//DZrUWq8RV34X
         SIB/K/zACVYQRNT20dx1r+YTlCOpHf6mUEZPNfFZN/gdmVpUrGxJ5LCrdgQYSZtPRHNn
         6clLZPQHJnQJM0H4JgJCqA6ysDRqToLJPJpIZEzHqO6G/7yhau7f6cVkd7dPWIy8BPC1
         GQ1ki3jjnZdm/EMGDNIpwT7aMZMiR4KKKq0zLyFlzPspkV/4ONU34z49JEhzvNsAgYgR
         HC/3EEVWDprazRJLRlUTo4SCwBJ8LPp7ETPDoIDe5X/uUPoYH8c6MS2A5CiNGvB6LMpw
         QSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgceQs6YATKdxHfCNYn6Tza2J5rBfHkY8t3odFqp3xM=;
        b=HW7OSnbTVo63kQktVkIULnKAv3uoIAqkYL4+9RmT6Ly38sOHVDW+T42iWKGAlxv6Dm
         l/i0TB+rPJpmyAwAtaZXwaEAykTgFBWM2sbLjXKdDCHaWEuWzLFnOzS9gXP93ul43VeR
         J6/sA6wlTYSnN7fOap2SRpT9m3uqdBYxD9MxTE610IZ3fws1IBRwlFH5cISLxUncT84B
         nW6I+i1cu3ZZO1764/4oCH6SmMfpUuQMeZttq2IGw0JdszM6LUVKCUAD2HJbcFA9H/oC
         QZTcRNPmLx5RhIo/e5/5HxGMaRhHCImV92+0raHuZ6bhEb7B/MQh1x3TswWF9FSS3JmJ
         vwkg==
X-Gm-Message-State: ANoB5pnhG5H9MQlojHDkfqGHMmXTJiBXG7ZjhzRyCDF0jRzVQOP1J1L3
        9YWy3Ea1s0YA8GPvfhKTBF/afd1yt8CHLBxRrXU=
X-Google-Smtp-Source: AA0mqf4fyRKs4cGhkhIW1PnCGFVz7JHslUjoBozP2m2e3VGCkOu31Rkq5MTUOVTPM+ZCpiHujqHkpmkLMnlZYJgzJk8=
X-Received: by 2002:a2e:b6c5:0:b0:279:d61b:181 with SMTP id
 m5-20020a2eb6c5000000b00279d61b0181mr11845862ljo.166.1671293174242; Sat, 17
 Dec 2022 08:06:14 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6504:1d9:b0:204:e392:5557 with HTTP; Sat, 17 Dec 2022
 08:06:13 -0800 (PST)
Reply-To: sgtkaylla202@gmail.com
From:   kayla manthey <kalinhester23@gmail.com>
Date:   Sat, 17 Dec 2022 16:06:13 +0000
Message-ID: <CAC8E+-8disWa+d1qT1nd_qZxQKHextQE9nxKPWoWNj_b_wecVA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hej k=C3=A4ra, sn=C3=A4lla har du f=C3=A5tt mitt meddelande, tack.
