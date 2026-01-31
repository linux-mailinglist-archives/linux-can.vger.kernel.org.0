Return-Path: <linux-can+bounces-6442-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hUjjE/BtfmlIYwIAu9opvQ
	(envelope-from <linux-can+bounces-6442-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 22:02:40 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D101C3EEC
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 22:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 002C6300EFB7
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 21:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD6637648A;
	Sat, 31 Jan 2026 21:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JfNIfzcB"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569F336AB61;
	Sat, 31 Jan 2026 21:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769893356; cv=none; b=NFB3/kzqretdOaphM/PaCftGxWhlcPQCcEXmEXE5xRzZVYjNtFsysmOQR3tYmoOULUcoK03RXPAktu3KV6pnjvsEvI1ueaUl3SL7VqIwpiYg70erEv2YW8xRDxTS0kg5OnlkiWrkV1TVn38ePhIaDR7IxJYSwaQ3QB+BANqAHZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769893356; c=relaxed/simple;
	bh=iR3gXia+hVbJETXRRDfjflIAiHQgeR3ZuBbE7Rc74zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQ568Ywz+b1Ne9jPlWTW9wBJFvladKBJ+3G0UVeUUeeo6Sbn5GsxuHE99Ad9R4tCvcvxZGuRLpymRQzHAfjqwVPjzR1pTGkiHeWze7HBV/nq6vDBD7laAuDG8SBp3mgZtkMYQ8Y5FNx22TdQ8cc45ypwZ5Q58Gl3Hvmouxm4Bww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JfNIfzcB; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769893353; x=1801429353;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iR3gXia+hVbJETXRRDfjflIAiHQgeR3ZuBbE7Rc74zE=;
  b=JfNIfzcBEtELxGwhKtM7g1MURM5RRwZheXuIl4hwZloNmxUacgS95by/
   Cfq79XeF7CoLw06hLGWHMc0xvwaRHlng1ZVKLvjetrKNZTvgeKx+oS9hm
   uM7FaEJYEfx3syHW4GGwfQcfl0IbiJJ+DPgQ+C6IjhLhpPmzm0uBxUxQc
   v5YT2U42C3qNuhSDtXZg2n48/77REotw6VtiRx13N+n8v/LNx2a9kbN3s
   Qgenh0pjEpLesv98oe8OdFMAkieatcMuuJJNEZilYLphhZnNHtOiSkyEi
   sWiumlyfgTAB/rm6dESFgSK72rMn6DiLDNZIo+lvJ3KoUJI2D5kmmaUju
   w==;
X-CSE-ConnectionGUID: Nwdd9yvTQkuoOfA6LsMr+Q==
X-CSE-MsgGUID: odMrv4BtSrOgOR5qQHQukg==
X-IronPort-AV: E=McAfee;i="6800,10657,11688"; a="81423715"
X-IronPort-AV: E=Sophos;i="6.21,265,1763452800"; 
   d="scan'208";a="81423715"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2026 13:02:33 -0800
X-CSE-ConnectionGUID: v1FQ9Ar0T4Gqym0DqpPsHw==
X-CSE-MsgGUID: I4iTiqRVTU6RRp4qHn0hmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,265,1763452800"; 
   d="scan'208";a="209375112"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 31 Jan 2026 13:02:29 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vmI6t-00000000ePA-0FAa;
	Sat, 31 Jan 2026 21:02:27 +0000
Date: Sun, 1 Feb 2026 05:02:25 +0800
From: kernel test robot <lkp@intel.com>
To: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 2/6] can: add CAN skb extension infrastructure
Message-ID: <202602010426.PnGrYAk3-lkp@intel.com>
References: <20260131-can_skb_ext-v7-2-dd0f8f84a83d@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131-can_skb_ext-v7-2-dd0f8f84a83d@hartkopp.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6442-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can,socketcan.hartkopp.net];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: 7D101C3EEC
X-Rspamd-Action: no action

Hi Oliver,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 239f09e258b906deced5c2a7c1ac8aed301b558b]

url:    https://github.com/intel-lab-lkp/linux/commits/Oliver-Hartkopp-via-B4-Relay/can-use-skb-hash-instead-of-private-variable-in-headroom/20260131-212921
base:   239f09e258b906deced5c2a7c1ac8aed301b558b
patch link:    https://lore.kernel.org/r/20260131-can_skb_ext-v7-2-dd0f8f84a83d%40hartkopp.net
patch subject: [PATCH net-next v7 2/6] can: add CAN skb extension infrastructure
config: s390-randconfig-r072-20260201 (https://download.01.org/0day-ci/archive/20260201/202602010426.PnGrYAk3-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
smatch version: v0.5.0-8994-gd50c5a4c

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602010426.PnGrYAk3-lkp@intel.com/

smatch warnings:
net/can/j1939/transport.c:1073 j1939_simple_txnext() warn: inconsistent indenting

vim +1073 net/can/j1939/transport.c

9d71dd0c700999 The j1939 authors 2018-10-08  1045  
9d71dd0c700999 The j1939 authors 2018-10-08  1046  static int j1939_simple_txnext(struct j1939_session *session)
9d71dd0c700999 The j1939 authors 2018-10-08  1047  {
9d71dd0c700999 The j1939 authors 2018-10-08  1048  	struct j1939_priv *priv = session->priv;
2030043e616cab Oleksij Rempel    2021-05-21  1049  	struct sk_buff *se_skb = j1939_session_skb_get(session);
9d71dd0c700999 The j1939 authors 2018-10-08  1050  	struct sk_buff *skb;
9d71dd0c700999 The j1939 authors 2018-10-08  1051  	int ret;
9d71dd0c700999 The j1939 authors 2018-10-08  1052  
9d71dd0c700999 The j1939 authors 2018-10-08  1053  	if (!se_skb)
9d71dd0c700999 The j1939 authors 2018-10-08  1054  		return 0;
9d71dd0c700999 The j1939 authors 2018-10-08  1055  
9d71dd0c700999 The j1939 authors 2018-10-08  1056  	skb = skb_clone(se_skb, GFP_ATOMIC);
2030043e616cab Oleksij Rempel    2021-05-21  1057  	if (!skb) {
2030043e616cab Oleksij Rempel    2021-05-21  1058  		ret = -ENOMEM;
2030043e616cab Oleksij Rempel    2021-05-21  1059  		goto out_free;
2030043e616cab Oleksij Rempel    2021-05-21  1060  	}
9d71dd0c700999 The j1939 authors 2018-10-08  1061  
f170b16e1461f2 Oliver Hartkopp   2026-01-31  1062  	/* the cloned skb points to the skb extension of the original se_skb
f170b16e1461f2 Oliver Hartkopp   2026-01-31  1063  	 * with an increased refcount. skb_ext_add() creates a copy to
f170b16e1461f2 Oliver Hartkopp   2026-01-31  1064  	 * separate the skb extension data which is needed to modify the
f170b16e1461f2 Oliver Hartkopp   2026-01-31  1065  	 * can_framelen in can_put_echo_skb().
f170b16e1461f2 Oliver Hartkopp   2026-01-31  1066  	 */
f170b16e1461f2 Oliver Hartkopp   2026-01-31  1067  	if (!skb_ext_add(skb, SKB_EXT_CAN)) {
f170b16e1461f2 Oliver Hartkopp   2026-01-31  1068  		kfree_skb(skb);
f170b16e1461f2 Oliver Hartkopp   2026-01-31  1069  		ret = -ENOMEM;
f170b16e1461f2 Oliver Hartkopp   2026-01-31  1070  		goto out_free;
f170b16e1461f2 Oliver Hartkopp   2026-01-31  1071  	}
f170b16e1461f2 Oliver Hartkopp   2026-01-31  1072  
9d71dd0c700999 The j1939 authors 2018-10-08 @1073         can_skb_set_owner(skb, se_skb->sk);
9d71dd0c700999 The j1939 authors 2018-10-08  1074  
9d71dd0c700999 The j1939 authors 2018-10-08  1075  	j1939_tp_set_rxtimeout(session, J1939_SIMPLE_ECHO_TIMEOUT_MS);
9d71dd0c700999 The j1939 authors 2018-10-08  1076  
9d71dd0c700999 The j1939 authors 2018-10-08  1077  	ret = j1939_send_one(priv, skb);
9d71dd0c700999 The j1939 authors 2018-10-08  1078  	if (ret)
2030043e616cab Oleksij Rempel    2021-05-21  1079  		goto out_free;
9d71dd0c700999 The j1939 authors 2018-10-08  1080  
cd85d3aed5cf44 Oleksij Rempel    2021-07-07  1081  	j1939_sk_errqueue(session, J1939_ERRQUEUE_TX_SCHED);
9d71dd0c700999 The j1939 authors 2018-10-08  1082  	j1939_sk_queue_activate_next(session);
9d71dd0c700999 The j1939 authors 2018-10-08  1083  
2030043e616cab Oleksij Rempel    2021-05-21  1084   out_free:
2030043e616cab Oleksij Rempel    2021-05-21  1085  	if (ret)
2030043e616cab Oleksij Rempel    2021-05-21  1086  		kfree_skb(se_skb);
2030043e616cab Oleksij Rempel    2021-05-21  1087  	else
2030043e616cab Oleksij Rempel    2021-05-21  1088  		consume_skb(se_skb);
2030043e616cab Oleksij Rempel    2021-05-21  1089  
2030043e616cab Oleksij Rempel    2021-05-21  1090  	return ret;
9d71dd0c700999 The j1939 authors 2018-10-08  1091  }
9d71dd0c700999 The j1939 authors 2018-10-08  1092  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

