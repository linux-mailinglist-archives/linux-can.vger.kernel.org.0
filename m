Return-Path: <linux-can+bounces-1413-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA75E96CBEE
	for <lists+linux-can@lfdr.de>; Thu,  5 Sep 2024 02:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FE8A1C2392C
	for <lists+linux-can@lfdr.de>; Thu,  5 Sep 2024 00:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59499440C;
	Thu,  5 Sep 2024 00:58:04 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1CD802
	for <linux-can@vger.kernel.org>; Thu,  5 Sep 2024 00:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725497884; cv=none; b=LoA9pyFobh7CSh0Kn+KX3WizWKmxe9jXszT93JlLlgeCWbowkT9LdqNQtqFqXaBJH3yGOfXk19REbBjYcXoj6Tnqm0E1PbOPhTMGTaI5bJTqVwyQzpzzdlLsRVRWw9jvZHjhw5gcMCaD3fahbiTZe8CTlsdjohuT+lS2YlNVwys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725497884; c=relaxed/simple;
	bh=/CKTM4kaa8II5li/dqw1AQYFfg9+TnNU8dZcYvGwwak=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PASaULl7fHJ+6rjsezBdkv1CbxwfvegoxAETC9xshFVoSLHCNQuQcwnL0LreIA4JyFDOOOvImAy7+dEMZekPHf5zXzLslVQOxeq6UXfC9/2cX4dHaRCuquXdQ+zDKkk5cBnDcS2TK4TDSQ3lLFTnTor8DkRnU9PBS2QiAQjoFVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d415635e6so3722935ab.1
        for <linux-can@vger.kernel.org>; Wed, 04 Sep 2024 17:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725497882; x=1726102682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZDdNCIFN4mGTaZwK+oYi0RgmIR7b2nHRUUiEY8+dg8=;
        b=My22cupDV0KT5wtkCtta6cuVo32+06pXfuw2t203poKURbslyjRaMI/qA4E87bolzE
         y0z/3k7SgVapQlw4XLYszUy8fxvgdiMeAll9tHUyY8icVlbnNkmVf1dxTlkudJkgQc3Y
         /Puxj7DoN4SW8f3S4pdjduu4h4nEYYtFle8ppXMX1JZXt5VkkhwaydmA2Dyia0bPGc8R
         d5koxlK0L3zPgHP4MOyNEIYxwulQumintExKFebFFfEzJo+DyAj5zQliwSxSwWyIcayW
         tah44+8nZtpIB5w9xFPkkHjjflKlkVtGOsh4uJVOCxeM0VH7t4/iZwFtjwvPnAOPqKda
         ktHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9Bqa/TffCZoo5Zokjm2myWN76VaQKU2MEwsVG5UgokNj7/GB83/IEuKfUt3Dg38mWnxBqWMGCAXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YztuZaXfXz+uuB0H7r+0lDBHBhYn0lzTQQ93sbUerZN8jg8pTP9
	A5jENpuzsKXe863/HqamizQS3QQILnJbeYCM0ZlkGLzLRWIG2EG4zIkmJ+FfsibEAjscjyx7+kN
	nUF2HTMqxzZONxAeYRHBVzN1sAMoY0l9Hbz8pLpNTwDXnDWy8rHxuEH0=
X-Google-Smtp-Source: AGHT+IEnsLK2ZSau2MDDBqtNGuj6kmEoDr2dm7p6FqAqPj/l4NzWbC4jEKIwiF0glFEzdNW8Cov1pEHMHrFeSCUDKrFFq93SdJHc
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3494:b0:4c0:a8a5:81cc with SMTP id
 8926c6da1cb9f-4d017e6f688mr1169419173.3.1725497882038; Wed, 04 Sep 2024
 17:58:02 -0700 (PDT)
Date: Wed, 04 Sep 2024 17:58:02 -0700
In-Reply-To: <20240904174339.7790-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000051e0ce062154c824@google.com>
Subject: Re: [syzbot] [can?] WARNING in remove_proc_entry (6)
From: syzbot <syzbot+0532ac7a06fb1a03187e@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, kuniyu@amazon.com, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mkl@pengutronix.de, netdev@vger.kernel.org, 
	pabeni@redhat.com, socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0532ac7a06fb1a03187e@syzkaller.appspotmail.com
Tested-by: syzbot+0532ac7a06fb1a03187e@syzkaller.appspotmail.com

Tested on:

commit:         bee2ef94 net: bridge: br_fdb_external_learn_add(): alw..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git HEAD
console output: https://syzkaller.appspot.com/x/log.txt?x=10b70e53980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=996585887acdadb3
dashboard link: https://syzkaller.appspot.com/bug?extid=0532ac7a06fb1a03187e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=156e82ab980000

Note: testing is done by a robot and is best-effort only.

