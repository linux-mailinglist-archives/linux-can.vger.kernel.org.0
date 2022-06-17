Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5708054F63E
	for <lists+linux-can@lfdr.de>; Fri, 17 Jun 2022 13:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbiFQLF1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 17 Jun 2022 07:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbiFQLFW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 17 Jun 2022 07:05:22 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D1B6C0E7
        for <linux-can@vger.kernel.org>; Fri, 17 Jun 2022 04:05:20 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b7so4353816ljr.6
        for <linux-can@vger.kernel.org>; Fri, 17 Jun 2022 04:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Jh3M8LDovYWs/mBJiVJoI/DS8xun0EDDqspVSX/swmY=;
        b=ROHIKr0gNV0WC7apLWhcODm7zYSh3/6QUaqKgcbqbXOFI/uMh4hBQ6upcXGxwiJ/ea
         hPqiLPa2R9eebMHPFiGqh717Dccn4ka2s0/KvMCi/TOwQO3a/c3sY5KkVJ2eYk4YrHGB
         042fDvxCKFqQTFh8tJLxUistHAqWAj3uWRZfbehzk0ha/KNmgulrGBoEBI1W4xOE/df/
         7+/OdWN+jIy3DDYtc7mfY7HfgP2rdLdgE8cXdNjGGwBXQ9Rl7wjy2agUMEbsuzP8u/gu
         rysIOmQ/OIRWs3aV+f3ZvobniLdzuqcAB1J0lawu7yzgxXysY3Rnqgubj2t/PUtc71Iz
         JTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Jh3M8LDovYWs/mBJiVJoI/DS8xun0EDDqspVSX/swmY=;
        b=VwKn1C/0GBxz3FRrBXvbtzs45UCbxYIPtfvbRYMW3i7OYNtHnioTmWCvMHBNnQgx6d
         3wW71CvV7r9TPcgRt806WG1gufWUdFojdVg2DdChSSIkHDYsRkzgQTtiyZzwtdkfJ3AV
         9Jks2P+L87OS8AEjTD4TC/5O4+wtZFx2jnxKkGIwyyNaD4gh93oAQJlGfYK3GoypIwRX
         AwndY78DzuOn+fKK/t9YJWUb8cb4oVWk7we3vzE6U3lhChO0E4953cWDM7jSJ4poxRFt
         JVqooHRF9fmJu8qf8lnxWq5CyM/Ihu4E6NHjE5/0IiF7kM4xr1Xafp6GF7u5I8v46N1/
         AEkA==
X-Gm-Message-State: AJIora+xkg8RXJVEdRLkdaJBYNEWKxeAgVdp0UQHvekpBGdVeVBGTbph
        KfkOMN3SF4W58Bzg4zlSr1B12FNRmaSACs8SSr31M3m0b/tQ4hAupOk=
X-Google-Smtp-Source: AGRyM1ueVXADqwQwX8wE6PBVnerb12awQRHEPMxhUZjdWtzw6oZXVUlciqHvp862TZcd+uRdXPJg8PFxtv7H1ZnQkLw=
X-Received: by 2002:a05:651c:1549:b0:258:4386:f6a2 with SMTP id
 y9-20020a05651c154900b002584386f6a2mr4641118ljp.527.1655463919194; Fri, 17
 Jun 2022 04:05:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:680f:0:0:0:0:0 with HTTP; Fri, 17 Jun 2022 04:05:18
 -0700 (PDT)
Reply-To: sj7209917@gmail.com
From:   Joseph smith <maelyskpeta@gmail.com>
Date:   Fri, 17 Jun 2022 04:05:18 -0700
Message-ID: <CACKGxpzUX=q9UbG9foKmEBftVUzUrBi0ih16YJngNh+fZyW+dA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi   are you available to  speak now
Thanks
