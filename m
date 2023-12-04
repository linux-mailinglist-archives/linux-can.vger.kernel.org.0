Return-Path: <linux-can+bounces-68-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BC58038B9
	for <lists+linux-can@lfdr.de>; Mon,  4 Dec 2023 16:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DB941C20A53
	for <lists+linux-can@lfdr.de>; Mon,  4 Dec 2023 15:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CDF2C84B;
	Mon,  4 Dec 2023 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kj2gm4s7"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16129C0;
	Mon,  4 Dec 2023 07:25:53 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2866e4ac34bso2097724a91.1;
        Mon, 04 Dec 2023 07:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701703552; x=1702308352; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LSxlw1Um8D3zeVQu2aobwpBAWAwmp9as4hXNtaUQ1ek=;
        b=kj2gm4s7jvBLSHRUWqecTnGxQftGnnmunMORhn3h+1DhKv4gBaNGO1qYo4h9LlLFsb
         KqwuzYrAsuwwBXq7dkbnkjs5nQ/yT0iDk6qfVjUk8vuRKEV/VnypLk7pGoWHQ7wZ4buB
         YREvxls6kqwkcitnVAOJzNB/EGDFCcD3uDA5eGlN+1b0dOSZHlWw5QZkmQ5GqpQxdbl/
         f+Tk6E4ntN1PSfFhj89wEun5Bu6+zHNx6bqlL5nRlANK/tAsukQGXdN4Jk2zdgvy6l02
         Wu975/ftfaiROv3Zix0nC8ZrixHo1iG06ok+HJGinu+k1+PhIZoaAJPohaVdffzFahPK
         l6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701703552; x=1702308352;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LSxlw1Um8D3zeVQu2aobwpBAWAwmp9as4hXNtaUQ1ek=;
        b=nrQXLF4GDsmAF/tRLAfgdMcffJMj2xOuQZBn1GDYBXRlB6JqE5FzlSOLtcrHP0PkuJ
         sUIQGopfgYXCgzm/TBeazZVzUjEh6oEfFY3tkgTxR5pC1fEcLfwv5+b2OV6y37r2mISk
         0dT3o7zoVku1lVRMt26cA9el1V1Rzwyo7lUUkiiday6Ms2ybVc5LbXMde+ZVaNx6Ci22
         wk+BwQweCOupBrunmZBkRBmn9zzeZWsb7+uXEFeqJeC1n+K5dqB5BTvHHGSSB+H6/9R5
         pVLAQ3AauHbY8P/bvLDJavqwS5FXoRvyXOugRgz4lkp1dz4MXFk0lIVbRarCnwPvQtRC
         ozfw==
X-Gm-Message-State: AOJu0YyF8EgCgkKZa900iVWUK7+ZP9HiVKv7LkF5HRJYtv1scYAtBnQZ
	NxiZdXE0yghYMYpIoZy9SDabI/taVZSaH9JDkU8=
X-Google-Smtp-Source: AGHT+IFWdlbjmS6iUEqv8tjmT8Q8epO+Z1IJlzy2rS1DlnkvT/8lZ2QBooU08IEkUgo6S3DwAAcbsqrUiXSfakUfw98=
X-Received: by 2002:a17:90a:f983:b0:286:6cc0:cad4 with SMTP id
 cq3-20020a17090af98300b002866cc0cad4mr3006153pjb.75.1701703551958; Mon, 04
 Dec 2023 07:25:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: xingwei lee <xrivendell7@gmail.com>
Date: Mon, 4 Dec 2023 23:25:40 +0800
Message-ID: <CABOYnLyMUdDvfUNcTS+1xQ+cVFjMO8jjzuTVjk7aoeje_Gw9Sw@mail.gmail.com>
Subject: Re: [PATCH v1] net: can: j1939: enhanced error handling for tightly
 received RTS messages in xtp_rx_rts_session_new
To: o.rempel@pengutronix.de
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mkl@pengutronix.de, robin@protonic.nl, 
	socketcan@hartkopp.net, stable@vger.kernel.org, 
	syzbot+daa36413a5cedf799ae4@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Hello, Oleksij.
I have reproduced this bug with repro.c
=* repro.txt =*
syz_usb_control_io$cdc_ncm(0xffffffffffffffff, 0x0, 0x0)
syz_usb_control_io$cdc_ncm(0xffffffffffffffff, 0x0, 0x0)
syz_usb_control_io$cdc_ncm(0xffffffffffffffff, 0x0, 0x0)
syz_usb_control_io$cdc_ncm(0xffffffffffffffff, 0x0, 0x0)
syz_usb_ep_write(0xffffffffffffffff, 0x82, 0x0, 0x0)
syz_usb_control_io$cdc_ncm(0xffffffffffffffff, 0x0, 0x0)
r0 = socket$nl_route(0x10, 0x3, 0x0)
ioctl$ifreq_SIOCGIFINDEX_vcan(r0, 0x8933,
&(0x7f0000001800)={'vxcan0\x00', <r1=>0x0})
r2 = socket$inet6_tcp(0xa, 0x1, 0x0)
ioctl$ifreq_SIOCGIFINDEX_vcan(r2, 0x8933,
&(0x7f0000000340)={'vxcan1\x00', <r3=>0x0})
sendmsg$nl_route(r0, &(0x7f0000000180)={0x0, 0x0,
&(0x7f0000000140)={&(0x7f00000003c0)=@can_newroute={0x24, 0x18, 0x1,
0x0, 0x0, {}, [@CGW_SRC_IF={0x8, 0x9, r1}, @CGW_DST_IF={0x8, 0xa,
r3}]}, 0x24}, 0x1, 0x4}, 0x0)
sendmsg$NL80211_CMD_CHANGE_NAN_CONFIG(0xffffffffffffffff, 0x0, 0x4000)
socket$inet6_tcp(0xa, 0x1, 0x0)
bpf$PROG_LOAD(0x5, 0x0, 0x0)
bpf$BPF_PROG_GET_FD_BY_ID(0xd, 0x0, 0x0)
setsockopt$sock_attach_bpf(0xffffffffffffffff, 0x1, 0x32, 0x0, 0x0)
getsockname$packet(0xffffffffffffffff, 0x0, 0x0)
openat$cgroup_ro(0xffffffffffffff9c, 0x0, 0xb00000000065808, 0x0)
mmap(&(0x7f0000000000/0xb36000)=nil, 0xb36000, 0x2, 0x28011,
0xffffffffffffffff, 0x0)
bpf$MAP_CREATE_CONST_STR(0x0, 0x0, 0x0)
bpf$BPF_PROG_RAW_TRACEPOINT_LOAD(0x5, 0x0, 0x0)
write$binfmt_script(0xffffffffffffffff, 0x0, 0x208e24b)
r4 = socket$can_j1939(0x1d, 0x2, 0x7)
ioctl$ifreq_SIOCGIFINDEX_vcan(r4, 0x8933,
&(0x7f0000000000)={'vxcan0\x00', <r5=>0x0})
bind$can_j1939(r4, &(0x7f0000000240)={0x1d, r5}, 0x18)
connect$can_j1939(r4, &(0x7f0000000080)={0x1d, r5}, 0x18)
sendmmsg(r4, &(0x7f00000038c0)=[{{&(0x7f0000000280)=@can, 0x80, 0x0}},
{{0x0, 0x0, &(0x7f0000001980)=[{&(0x7f0000001640)="03", 0x1a000}],
0x1}}], 0x2, 0x0)
r6 = socket$can_j1939(0x1d, 0x2, 0x7)
connect$can_j1939(r6, 0x0, 0x0)

=* repro.c =*
// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <arpa/inet.h>
#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/capability.h>
#include <linux/genetlink.h>
#include <linux/if_addr.h>
#include <linux/if_ether.h>
#include <linux/if_link.h>
#include <linux/if_tun.h>
#include <linux/in6.h>
#include <linux/ip.h>
#include <linux/neighbour.h>
#include <linux/net.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <linux/tcp.h>
#include <linux/usb/ch9.h>
#include <linux/veth.h>
#include <net/if.h>
#include <net/if_arp.h>
#include <netinet/in.h>
#include <sched.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mount.h>
#include <sys/prctl.h>
#include <sys/resource.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#ifndef __NR_bpf
#define __NR_bpf 321
#endif

static unsigned long long procid;

static void sleep_ms(uint64_t ms) { usleep(ms * 1000); }

static uint64_t current_time_ms(void) {
  struct timespec ts;
  if (clock_gettime(CLOCK_MONOTONIC, &ts)) exit(1);
  return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static bool write_file(const char* file, const char* what, ...) {
  char buf[1024];
  va_list args;
  va_start(args, what);
  vsnprintf(buf, sizeof(buf), what, args);
  va_end(args);
  buf[sizeof(buf) - 1] = 0;
  int len = strlen(buf);
  int fd = open(file, O_WRONLY | O_CLOEXEC);
  if (fd == -1) return false;
  if (write(fd, buf, len) != len) {
    int err = errno;
    close(fd);
    errno = err;
    return false;
  }
  close(fd);
  return true;
}

struct nlmsg {
  char* pos;
  int nesting;
  struct nlattr* nested[8];
  char buf[4096];
};

static void netlink_init(struct nlmsg* nlmsg, int typ, int flags,
                         const void* data, int size) {
  memset(nlmsg, 0, sizeof(*nlmsg));
  struct nlmsghdr* hdr = (struct nlmsghdr*)nlmsg->buf;
  hdr->nlmsg_type = typ;
  hdr->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | flags;
  memcpy(hdr + 1, data, size);
  nlmsg->pos = (char*)(hdr + 1) + NLMSG_ALIGN(size);
}

static void netlink_attr(struct nlmsg* nlmsg, int typ, const void* data,
                         int size) {
  struct nlattr* attr = (struct nlattr*)nlmsg->pos;
  attr->nla_len = sizeof(*attr) + size;
  attr->nla_type = typ;
  if (size > 0) memcpy(attr + 1, data, size);
  nlmsg->pos += NLMSG_ALIGN(attr->nla_len);
}

static void netlink_nest(struct nlmsg* nlmsg, int typ) {
  struct nlattr* attr = (struct nlattr*)nlmsg->pos;
  attr->nla_type = typ;
  nlmsg->pos += sizeof(*attr);
  nlmsg->nested[nlmsg->nesting++] = attr;
}

static void netlink_done(struct nlmsg* nlmsg) {
  struct nlattr* attr = nlmsg->nested[--nlmsg->nesting];
  attr->nla_len = nlmsg->pos - (char*)attr;
}

static int netlink_send_ext(struct nlmsg* nlmsg, int sock, uint16_t reply_type,
                            int* reply_len, bool dofail) {
  if (nlmsg->pos > nlmsg->buf + sizeof(nlmsg->buf) || nlmsg->nesting) exit(1);
  struct nlmsghdr* hdr = (struct nlmsghdr*)nlmsg->buf;
  hdr->nlmsg_len = nlmsg->pos - nlmsg->buf;
  struct sockaddr_nl addr;
  memset(&addr, 0, sizeof(addr));
  addr.nl_family = AF_NETLINK;
  ssize_t n = sendto(sock, nlmsg->buf, hdr->nlmsg_len, 0,
                     (struct sockaddr*)&addr, sizeof(addr));
  if (n != (ssize_t)hdr->nlmsg_len) {
    if (dofail) exit(1);
    return -1;
  }
  n = recv(sock, nlmsg->buf, sizeof(nlmsg->buf), 0);
  if (reply_len) *reply_len = 0;
  if (n < 0) {
    if (dofail) exit(1);
    return -1;
  }
  if (n < (ssize_t)sizeof(struct nlmsghdr)) {
    errno = EINVAL;
    if (dofail) exit(1);
    return -1;
  }
  if (hdr->nlmsg_type == NLMSG_DONE) return 0;
  if (reply_len && hdr->nlmsg_type == reply_type) {
    *reply_len = n;
    return 0;
  }
  if (n < (ssize_t)(sizeof(struct nlmsghdr) + sizeof(struct nlmsgerr))) {
    errno = EINVAL;
    if (dofail) exit(1);
    return -1;
  }
  if (hdr->nlmsg_type != NLMSG_ERROR) {
    errno = EINVAL;
    if (dofail) exit(1);
    return -1;
  }
  errno = -((struct nlmsgerr*)(hdr + 1))->error;
  return -errno;
}

static int netlink_send(struct nlmsg* nlmsg, int sock) {
  return netlink_send_ext(nlmsg, sock, 0, NULL, true);
}

static int netlink_query_family_id(struct nlmsg* nlmsg, int sock,
                                   const char* family_name, bool dofail) {
  struct genlmsghdr genlhdr;
  memset(&genlhdr, 0, sizeof(genlhdr));
  genlhdr.cmd = CTRL_CMD_GETFAMILY;
  netlink_init(nlmsg, GENL_ID_CTRL, 0, &genlhdr, sizeof(genlhdr));
  netlink_attr(nlmsg, CTRL_ATTR_FAMILY_NAME, family_name,
               strnlen(family_name, GENL_NAMSIZ - 1) + 1);
  int n = 0;
  int err = netlink_send_ext(nlmsg, sock, GENL_ID_CTRL, &n, dofail);
  if (err < 0) {
    return -1;
  }
  uint16_t id = 0;
  struct nlattr* attr = (struct nlattr*)(nlmsg->buf + NLMSG_HDRLEN +
                                         NLMSG_ALIGN(sizeof(genlhdr)));
  for (; (char*)attr < nlmsg->buf + n;
       attr = (struct nlattr*)((char*)attr + NLMSG_ALIGN(attr->nla_len))) {
    if (attr->nla_type == CTRL_ATTR_FAMILY_ID) {
      id = *(uint16_t*)(attr + 1);
      break;
    }
  }
  if (!id) {
    errno = EINVAL;
    return -1;
  }
  recv(sock, nlmsg->buf, sizeof(nlmsg->buf), 0);
  return id;
}

static int netlink_next_msg(struct nlmsg* nlmsg, unsigned int offset,
                            unsigned int total_len) {
  struct nlmsghdr* hdr = (struct nlmsghdr*)(nlmsg->buf + offset);
  if (offset == total_len || offset + hdr->nlmsg_len > total_len) return -1;
  return hdr->nlmsg_len;
}

static void netlink_add_device_impl(struct nlmsg* nlmsg, const char* type,
                                    const char* name, bool up) {
  struct ifinfomsg hdr;
  memset(&hdr, 0, sizeof(hdr));
  if (up) hdr.ifi_flags = hdr.ifi_change = IFF_UP;
  netlink_init(nlmsg, RTM_NEWLINK, NLM_F_EXCL | NLM_F_CREATE, &hdr,
               sizeof(hdr));
  if (name) netlink_attr(nlmsg, IFLA_IFNAME, name, strlen(name));
  netlink_nest(nlmsg, IFLA_LINKINFO);
  netlink_attr(nlmsg, IFLA_INFO_KIND, type, strlen(type));
}

static void netlink_add_device(struct nlmsg* nlmsg, int sock, const char* type,
                               const char* name) {
  netlink_add_device_impl(nlmsg, type, name, false);
  netlink_done(nlmsg);
  int err = netlink_send(nlmsg, sock);
  if (err < 0) {
  }
}

static void netlink_add_veth(struct nlmsg* nlmsg, int sock, const char* name,
                             const char* peer) {
  netlink_add_device_impl(nlmsg, "veth", name, false);
  netlink_nest(nlmsg, IFLA_INFO_DATA);
  netlink_nest(nlmsg, VETH_INFO_PEER);
  nlmsg->pos += sizeof(struct ifinfomsg);
  netlink_attr(nlmsg, IFLA_IFNAME, peer, strlen(peer));
  netlink_done(nlmsg);
  netlink_done(nlmsg);
  netlink_done(nlmsg);
  int err = netlink_send(nlmsg, sock);
  if (err < 0) {
  }
}

static void netlink_add_xfrm(struct nlmsg* nlmsg, int sock, const char* name) {
  netlink_add_device_impl(nlmsg, "xfrm", name, true);
  netlink_nest(nlmsg, IFLA_INFO_DATA);
  int if_id = 1;
  netlink_attr(nlmsg, 2, &if_id, sizeof(if_id));
  netlink_done(nlmsg);
  netlink_done(nlmsg);
  int err = netlink_send(nlmsg, sock);
  if (err < 0) {
  }
}

static void netlink_add_hsr(struct nlmsg* nlmsg, int sock, const char* name,
                            const char* slave1, const char* slave2) {
  netlink_add_device_impl(nlmsg, "hsr", name, false);
  netlink_nest(nlmsg, IFLA_INFO_DATA);
  int ifindex1 = if_nametoindex(slave1);
  netlink_attr(nlmsg, IFLA_HSR_SLAVE1, &ifindex1, sizeof(ifindex1));
  int ifindex2 = if_nametoindex(slave2);
  netlink_attr(nlmsg, IFLA_HSR_SLAVE2, &ifindex2, sizeof(ifindex2));
  netlink_done(nlmsg);
  netlink_done(nlmsg);
  int err = netlink_send(nlmsg, sock);
  if (err < 0) {
  }
}

static void netlink_add_linked(struct nlmsg* nlmsg, int sock, const char* type,
                               const char* name, const char* link) {
  netlink_add_device_impl(nlmsg, type, name, false);
  netlink_done(nlmsg);
  int ifindex = if_nametoindex(link);
  netlink_attr(nlmsg, IFLA_LINK, &ifindex, sizeof(ifindex));
  int err = netlink_send(nlmsg, sock);
  if (err < 0) {
  }
}

static void netlink_add_vlan(struct nlmsg* nlmsg, int sock, const char* name,
                             const char* link, uint16_t id, uint16_t proto) {
  netlink_add_device_impl(nlmsg, "vlan", name, false);
  netlink_nest(nlmsg, IFLA_INFO_DATA);
  netlink_attr(nlmsg, IFLA_VLAN_ID, &id, sizeof(id));
  netlink_attr(nlmsg, IFLA_VLAN_PROTOCOL, &proto, sizeof(proto));
  netlink_done(nlmsg);
  netlink_done(nlmsg);
  int ifindex = if_nametoindex(link);
  netlink_attr(nlmsg, IFLA_LINK, &ifindex, sizeof(ifindex));
  int err = netlink_send(nlmsg, sock);
  if (err < 0) {
  }
}

static void netlink_add_macvlan(struct nlmsg* nlmsg, int sock, const char* name,
                                const char* link) {
  netlink_add_device_impl(nlmsg, "macvlan", name, false);
  netlink_nest(nlmsg, IFLA_INFO_DATA);
  uint32_t mode = MACVLAN_MODE_BRIDGE;
  netlink_attr(nlmsg, IFLA_MACVLAN_MODE, &mode, sizeof(mode));
  netlink_done(nlmsg);
  netlink_done(nlmsg);
  int ifindex = if_nametoindex(link);
  netlink_attr(nlmsg, IFLA_LINK, &ifindex, sizeof(ifindex));
  int err = netlink_send(nlmsg, sock);
  if (err < 0) {
  }
}

static void netlink_add_geneve(struct nlmsg* nlmsg, int sock, const char* name,
                               uint32_t vni, struct in_addr* addr4,
                               struct in6_addr* addr6) {
  netlink_add_device_impl(nlmsg, "geneve", name, false);
  netlink_nest(nlmsg, IFLA_INFO_DATA);
  netlink_attr(nlmsg, IFLA_GENEVE_ID, &vni, sizeof(vni));
  if (addr4) netlink_attr(nlmsg, IFLA_GENEVE_REMOTE, addr4, sizeof(*addr4));
  if (addr6) netlink_attr(nlmsg, IFLA_GENEVE_REMOTE6, addr6, sizeof(*addr6));
  netlink_done(nlmsg);
  netlink_done(nlmsg);
  int err = netlink_send(nlmsg, sock);
  if (err < 0) {
  }
}

#define IFLA_IPVLAN_FLAGS 2
#define IPVLAN_MODE_L3S 2
#undef IPVLAN_F_VEPA
#define IPVLAN_F_VEPA 2

static void netlink_add_ipvlan(struct nlmsg* nlmsg, int sock, const char* name,
                               const char* link, uint16_t mode,
                               uint16_t flags) {
  netlink_add_device_impl(nlmsg, "ipvlan", name, false);
  netlink_nest(nlmsg, IFLA_INFO_DATA);
  netlink_attr(nlmsg, IFLA_IPVLAN_MODE, &mode, sizeof(mode));
  netlink_attr(nlmsg, IFLA_IPVLAN_FLAGS, &flags, sizeof(flags));
  netlink_done(nlmsg);
  netlink_done(nlmsg);
  int ifindex = if_nametoindex(link);
  netlink_attr(nlmsg, IFLA_LINK, &ifindex, sizeof(ifindex));
  int err = netlink_send(nlmsg, sock);
  if (err < 0) {
  }
}

static void netlink_device_change(struct nlmsg* nlmsg, int sock,
                                  const char* name, bool up, const char* master,
                                  const void* mac, int macsize,
                                  const char* new_name) {
  struct ifinfomsg hdr;
  memset(&hdr, 0, sizeof(hdr));
  if (up) hdr.ifi_flags = hdr.ifi_change = IFF_UP;
  hdr.ifi_index = if_nametoindex(name);
  netlink_init(nlmsg, RTM_NEWLINK, 0, &hdr, sizeof(hdr));
  if (new_name) netlink_attr(nlmsg, IFLA_IFNAME, new_name, strlen(new_name));
  if (master) {
    int ifindex = if_nametoindex(master);
    netlink_attr(nlmsg, IFLA_MASTER, &ifindex, sizeof(ifindex));
  }
  if (macsize) netlink_attr(nlmsg, IFLA_ADDRESS, mac, macsize);
  int err = netlink_send(nlmsg, sock);
  if (err < 0) {
  }
}

static int netlink_add_addr(struct nlmsg* nlmsg, int sock, const char* dev,
                            const void* addr, int addrsize) {
  struct ifaddrmsg hdr;
  memset(&hdr, 0, sizeof(hdr));
  hdr.ifa_family = addrsize == 4 ? AF_INET : AF_INET6;
  hdr.ifa_prefixlen = addrsize == 4 ? 24 : 120;
  hdr.ifa_scope = RT_SCOPE_UNIVERSE;
  hdr.ifa_index = if_nametoindex(dev);
  netlink_init(nlmsg, RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, &hdr,
               sizeof(hdr));
  netlink_attr(nlmsg, IFA_LOCAL, addr, addrsize);
  netlink_attr(nlmsg, IFA_ADDRESS, addr, addrsize);
  return netlink_send(nlmsg, sock);
}

static void netlink_add_addr4(struct nlmsg* nlmsg, int sock, const char* dev,
                              const char* addr) {
  struct in_addr in_addr;
  inet_pton(AF_INET, addr, &in_addr);
  int err = netlink_add_addr(nlmsg, sock, dev, &in_addr, sizeof(in_addr));
  if (err < 0) {
  }
}

static void netlink_add_addr6(struct nlmsg* nlmsg, int sock, const char* dev,
                              const char* addr) {
  struct in6_addr in6_addr;
  inet_pton(AF_INET6, addr, &in6_addr);
  int err = netlink_add_addr(nlmsg, sock, dev, &in6_addr, sizeof(in6_addr));
  if (err < 0) {
  }
}

static struct nlmsg nlmsg;

#define DEVLINK_FAMILY_NAME "devlink"

#define DEVLINK_CMD_PORT_GET 5
#define DEVLINK_ATTR_BUS_NAME 1
#define DEVLINK_ATTR_DEV_NAME 2
#define DEVLINK_ATTR_NETDEV_NAME 7

static struct nlmsg nlmsg2;

static void initialize_devlink_ports(const char* bus_name, const char* dev_name,
                                     const char* netdev_prefix) {
  struct genlmsghdr genlhdr;
  int len, total_len, id, err, offset;
  uint16_t netdev_index;
  int sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
  if (sock == -1) exit(1);
  int rtsock = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
  if (rtsock == -1) exit(1);
  id = netlink_query_family_id(&nlmsg, sock, DEVLINK_FAMILY_NAME, true);
  if (id == -1) goto error;
  memset(&genlhdr, 0, sizeof(genlhdr));
  genlhdr.cmd = DEVLINK_CMD_PORT_GET;
  netlink_init(&nlmsg, id, NLM_F_DUMP, &genlhdr, sizeof(genlhdr));
  netlink_attr(&nlmsg, DEVLINK_ATTR_BUS_NAME, bus_name, strlen(bus_name) + 1);
  netlink_attr(&nlmsg, DEVLINK_ATTR_DEV_NAME, dev_name, strlen(dev_name) + 1);
  err = netlink_send_ext(&nlmsg, sock, id, &total_len, true);
  if (err < 0) {
    goto error;
  }
  offset = 0;
  netdev_index = 0;
  while ((len = netlink_next_msg(&nlmsg, offset, total_len)) != -1) {
    struct nlattr* attr = (struct nlattr*)(nlmsg.buf + offset + NLMSG_HDRLEN +
                                           NLMSG_ALIGN(sizeof(genlhdr)));
    for (; (char*)attr < nlmsg.buf + offset + len;
         attr = (struct nlattr*)((char*)attr + NLMSG_ALIGN(attr->nla_len))) {
      if (attr->nla_type == DEVLINK_ATTR_NETDEV_NAME) {
        char* port_name;
        char netdev_name[IFNAMSIZ];
        port_name = (char*)(attr + 1);
        snprintf(netdev_name, sizeof(netdev_name), "%s%d", netdev_prefix,
                 netdev_index);
        netlink_device_change(&nlmsg2, rtsock, port_name, true, 0, 0, 0,
                              netdev_name);
        break;
      }
    }
    offset += len;
    netdev_index++;
  }
error:
  close(rtsock);
  close(sock);
}

#define DEV_IPV4 "172.20.20.%d"
#define DEV_IPV6 "fe80::%02x"
#define DEV_MAC 0x00aaaaaaaaaa

static void netdevsim_add(unsigned int addr, unsigned int port_count) {
  write_file("/sys/bus/netdevsim/del_device", "%u", addr);
  if (write_file("/sys/bus/netdevsim/new_device", "%u %u", addr, port_count)) {
    char buf[32];
    snprintf(buf, sizeof(buf), "netdevsim%d", addr);
    initialize_devlink_ports("netdevsim", buf, "netdevsim");
  }
}

#define WG_GENL_NAME "wireguard"
enum wg_cmd {
  WG_CMD_GET_DEVICE,
  WG_CMD_SET_DEVICE,
};
enum wgdevice_attribute {
  WGDEVICE_A_UNSPEC,
  WGDEVICE_A_IFINDEX,
  WGDEVICE_A_IFNAME,
  WGDEVICE_A_PRIVATE_KEY,
  WGDEVICE_A_PUBLIC_KEY,
  WGDEVICE_A_FLAGS,
  WGDEVICE_A_LISTEN_PORT,
  WGDEVICE_A_FWMARK,
  WGDEVICE_A_PEERS,
};
enum wgpeer_attribute {
  WGPEER_A_UNSPEC,
  WGPEER_A_PUBLIC_KEY,
  WGPEER_A_PRESHARED_KEY,
  WGPEER_A_FLAGS,
  WGPEER_A_ENDPOINT,
  WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
  WGPEER_A_LAST_HANDSHAKE_TIME,
  WGPEER_A_RX_BYTES,
  WGPEER_A_TX_BYTES,
  WGPEER_A_ALLOWEDIPS,
  WGPEER_A_PROTOCOL_VERSION,
};
enum wgallowedip_attribute {
  WGALLOWEDIP_A_UNSPEC,
  WGALLOWEDIP_A_FAMILY,
  WGALLOWEDIP_A_IPADDR,
  WGALLOWEDIP_A_CIDR_MASK,
};

static void netlink_wireguard_setup(void) {
  const char ifname_a[] = "wg0";
  const char ifname_b[] = "wg1";
  const char ifname_c[] = "wg2";
  const char private_a[] =
      "\xa0\x5c\xa8\x4f\x6c\x9c\x8e\x38\x53\xe2\xfd\x7a\x70\xae\x0f\xb2\x0f\xa1"
      "\x52\x60\x0c\xb0\x08\x45\x17\x4f\x08\x07\x6f\x8d\x78\x43";
  const char private_b[] =
      "\xb0\x80\x73\xe8\xd4\x4e\x91\xe3\xda\x92\x2c\x22\x43\x82\x44\xbb\x88\x5c"
      "\x69\xe2\x69\xc8\xe9\xd8\x35\xb1\x14\x29\x3a\x4d\xdc\x6e";
  const char private_c[] =
      "\xa0\xcb\x87\x9a\x47\xf5\xbc\x64\x4c\x0e\x69\x3f\xa6\xd0\x31\xc7\x4a\x15"
      "\x53\xb6\xe9\x01\xb9\xff\x2f\x51\x8c\x78\x04\x2f\xb5\x42";
  const char public_a[] =
      "\x97\x5c\x9d\x81\xc9\x83\xc8\x20\x9e\xe7\x81\x25\x4b\x89\x9f\x8e\xd9\x25"
      "\xae\x9f\x09\x23\xc2\x3c\x62\xf5\x3c\x57\xcd\xbf\x69\x1c";
  const char public_b[] =
      "\xd1\x73\x28\x99\xf6\x11\xcd\x89\x94\x03\x4d\x7f\x41\x3d\xc9\x57\x63\x0e"
      "\x54\x93\xc2\x85\xac\xa4\x00\x65\xcb\x63\x11\xbe\x69\x6b";
  const char public_c[] =
      "\xf4\x4d\xa3\x67\xa8\x8e\xe6\x56\x4f\x02\x02\x11\x45\x67\x27\x08\x2f\x5c"
      "\xeb\xee\x8b\x1b\xf5\xeb\x73\x37\x34\x1b\x45\x9b\x39\x22";
  const uint16_t listen_a = 20001;
  const uint16_t listen_b = 20002;
  const uint16_t listen_c = 20003;
  const uint16_t af_inet = AF_INET;
  const uint16_t af_inet6 = AF_INET6;
  const struct sockaddr_in endpoint_b_v4 = {
      .sin_family = AF_INET,
      .sin_port = htons(listen_b),
      .sin_addr = {htonl(INADDR_LOOPBACK)}};
  const struct sockaddr_in endpoint_c_v4 = {
      .sin_family = AF_INET,
      .sin_port = htons(listen_c),
      .sin_addr = {htonl(INADDR_LOOPBACK)}};
  struct sockaddr_in6 endpoint_a_v6 = {.sin6_family = AF_INET6,
                                       .sin6_port = htons(listen_a)};
  endpoint_a_v6.sin6_addr = in6addr_loopback;
  struct sockaddr_in6 endpoint_c_v6 = {.sin6_family = AF_INET6,
                                       .sin6_port = htons(listen_c)};
  endpoint_c_v6.sin6_addr = in6addr_loopback;
  const struct in_addr first_half_v4 = {0};
  const struct in_addr second_half_v4 = {(uint32_t)htonl(128 << 24)};
  const struct in6_addr first_half_v6 = {{{0}}};
  const struct in6_addr second_half_v6 = {{{0x80}}};
  const uint8_t half_cidr = 1;
  const uint16_t persistent_keepalives[] = {1, 3, 7, 9, 14, 19};
  struct genlmsghdr genlhdr = {.cmd = WG_CMD_SET_DEVICE, .version = 1};
  int sock;
  int id, err;
  sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
  if (sock == -1) {
    return;
  }
  id = netlink_query_family_id(&nlmsg, sock, WG_GENL_NAME, true);
  if (id == -1) goto error;
  netlink_init(&nlmsg, id, 0, &genlhdr, sizeof(genlhdr));
  netlink_attr(&nlmsg, WGDEVICE_A_IFNAME, ifname_a, strlen(ifname_a) + 1);
  netlink_attr(&nlmsg, WGDEVICE_A_PRIVATE_KEY, private_a, 32);
  netlink_attr(&nlmsg, WGDEVICE_A_LISTEN_PORT, &listen_a, 2);
  netlink_nest(&nlmsg, NLA_F_NESTED | WGDEVICE_A_PEERS);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGPEER_A_PUBLIC_KEY, public_b, 32);
  netlink_attr(&nlmsg, WGPEER_A_ENDPOINT, &endpoint_b_v4,
               sizeof(endpoint_b_v4));
  netlink_attr(&nlmsg, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
               &persistent_keepalives[0], 2);
  netlink_nest(&nlmsg, NLA_F_NESTED | WGPEER_A_ALLOWEDIPS);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet, 2);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &first_half_v4,
               sizeof(first_half_v4));
  netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
  netlink_done(&nlmsg);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet6, 2);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &first_half_v6,
               sizeof(first_half_v6));
  netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
  netlink_done(&nlmsg);
  netlink_done(&nlmsg);
  netlink_done(&nlmsg);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGPEER_A_PUBLIC_KEY, public_c, 32);
  netlink_attr(&nlmsg, WGPEER_A_ENDPOINT, &endpoint_c_v6,
               sizeof(endpoint_c_v6));
  netlink_attr(&nlmsg, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
               &persistent_keepalives[1], 2);
  netlink_nest(&nlmsg, NLA_F_NESTED | WGPEER_A_ALLOWEDIPS);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet, 2);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &second_half_v4,
               sizeof(second_half_v4));
  netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
  netlink_done(&nlmsg);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet6, 2);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &second_half_v6,
               sizeof(second_half_v6));
  netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
  netlink_done(&nlmsg);
  netlink_done(&nlmsg);
  netlink_done(&nlmsg);
  netlink_done(&nlmsg);
  err = netlink_send(&nlmsg, sock);
  if (err < 0) {
  }
  netlink_init(&nlmsg, id, 0, &genlhdr, sizeof(genlhdr));
  netlink_attr(&nlmsg, WGDEVICE_A_IFNAME, ifname_b, strlen(ifname_b) + 1);
  netlink_attr(&nlmsg, WGDEVICE_A_PRIVATE_KEY, private_b, 32);
  netlink_attr(&nlmsg, WGDEVICE_A_LISTEN_PORT, &listen_b, 2);
  netlink_nest(&nlmsg, NLA_F_NESTED | WGDEVICE_A_PEERS);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGPEER_A_PUBLIC_KEY, public_a, 32);
  netlink_attr(&nlmsg, WGPEER_A_ENDPOINT, &endpoint_a_v6,
               sizeof(endpoint_a_v6));
  netlink_attr(&nlmsg, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
               &persistent_keepalives[2], 2);
  netlink_nest(&nlmsg, NLA_F_NESTED | WGPEER_A_ALLOWEDIPS);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet, 2);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &first_half_v4,
               sizeof(first_half_v4));
  netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
  netlink_done(&nlmsg);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet6, 2);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &first_half_v6,
               sizeof(first_half_v6));
  netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
  netlink_done(&nlmsg);
  netlink_done(&nlmsg);
  netlink_done(&nlmsg);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGPEER_A_PUBLIC_KEY, public_c, 32);
  netlink_attr(&nlmsg, WGPEER_A_ENDPOINT, &endpoint_c_v4,
               sizeof(endpoint_c_v4));
  netlink_attr(&nlmsg, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
               &persistent_keepalives[3], 2);
  netlink_nest(&nlmsg, NLA_F_NESTED | WGPEER_A_ALLOWEDIPS);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet, 2);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &second_half_v4,
               sizeof(second_half_v4));
  netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
  netlink_done(&nlmsg);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet6, 2);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &second_half_v6,
               sizeof(second_half_v6));
  netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
  netlink_done(&nlmsg);
  netlink_done(&nlmsg);
  netlink_done(&nlmsg);
  netlink_done(&nlmsg);
  err = netlink_send(&nlmsg, sock);
  if (err < 0) {
  }
  netlink_init(&nlmsg, id, 0, &genlhdr, sizeof(genlhdr));
  netlink_attr(&nlmsg, WGDEVICE_A_IFNAME, ifname_c, strlen(ifname_c) + 1);
  netlink_attr(&nlmsg, WGDEVICE_A_PRIVATE_KEY, private_c, 32);
  netlink_attr(&nlmsg, WGDEVICE_A_LISTEN_PORT, &listen_c, 2);
  netlink_nest(&nlmsg, NLA_F_NESTED | WGDEVICE_A_PEERS);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGPEER_A_PUBLIC_KEY, public_a, 32);
  netlink_attr(&nlmsg, WGPEER_A_ENDPOINT, &endpoint_a_v6,
               sizeof(endpoint_a_v6));
  netlink_attr(&nlmsg, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
               &persistent_keepalives[4], 2);
  netlink_nest(&nlmsg, NLA_F_NESTED | WGPEER_A_ALLOWEDIPS);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet, 2);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &first_half_v4,
               sizeof(first_half_v4));
  netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
  netlink_done(&nlmsg);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet6, 2);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &first_half_v6,
               sizeof(first_half_v6));
  netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
  netlink_done(&nlmsg);
  netlink_done(&nlmsg);
  netlink_done(&nlmsg);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGPEER_A_PUBLIC_KEY, public_b, 32);
  netlink_attr(&nlmsg, WGPEER_A_ENDPOINT, &endpoint_b_v4,
               sizeof(endpoint_b_v4));
  netlink_attr(&nlmsg, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
               &persistent_keepalives[5], 2);
  netlink_nest(&nlmsg, NLA_F_NESTED | WGPEER_A_ALLOWEDIPS);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet, 2);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &second_half_v4,
               sizeof(second_half_v4));
  netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
  netlink_done(&nlmsg);
  netlink_nest(&nlmsg, NLA_F_NESTED | 0);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet6, 2);
  netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &second_half_v6,
               sizeof(second_half_v6));
  netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
  netlink_done(&nlmsg);
  netlink_done(&nlmsg);
  netlink_done(&nlmsg);
  netlink_done(&nlmsg);
  err = netlink_send(&nlmsg, sock);
  if (err < 0) {
  }

error:
  close(sock);
}

static void initialize_netdevices(void) {
  char netdevsim[16];
  sprintf(netdevsim, "netdevsim%d", (int)procid);
  struct {
    const char* type;
    const char* dev;
  } devtypes[] = {
      {"ip6gretap", "ip6gretap0"}, {"bridge", "bridge0"}, {"vcan", "vcan0"},
      {"bond", "bond0"},           {"team", "team0"},     {"dummy", "dummy0"},
      {"nlmon", "nlmon0"},         {"caif", "caif0"},     {"batadv", "batadv0"},
      {"vxcan", "vxcan1"},         {"veth", 0},           {"wireguard", "wg0"},
      {"wireguard", "wg1"},        {"wireguard", "wg2"},
  };
  const char* devmasters[] = {"bridge", "bond", "team", "batadv"};
  struct {
    const char* name;
    int macsize;
    bool noipv6;
  } devices[] = {
      {"lo", ETH_ALEN},
      {"sit0", 0},
      {"bridge0", ETH_ALEN},
      {"vcan0", 0, true},
      {"tunl0", 0},
      {"gre0", 0},
      {"gretap0", ETH_ALEN},
      {"ip_vti0", 0},
      {"ip6_vti0", 0},
      {"ip6tnl0", 0},
      {"ip6gre0", 0},
      {"ip6gretap0", ETH_ALEN},
      {"erspan0", ETH_ALEN},
      {"bond0", ETH_ALEN},
      {"veth0", ETH_ALEN},
      {"veth1", ETH_ALEN},
      {"team0", ETH_ALEN},
      {"veth0_to_bridge", ETH_ALEN},
      {"veth1_to_bridge", ETH_ALEN},
      {"veth0_to_bond", ETH_ALEN},
      {"veth1_to_bond", ETH_ALEN},
      {"veth0_to_team", ETH_ALEN},
      {"veth1_to_team", ETH_ALEN},
      {"veth0_to_hsr", ETH_ALEN},
      {"veth1_to_hsr", ETH_ALEN},
      {"hsr0", 0},
      {"dummy0", ETH_ALEN},
      {"nlmon0", 0},
      {"vxcan0", 0, true},
      {"vxcan1", 0, true},
      {"caif0", ETH_ALEN},
      {"batadv0", ETH_ALEN},
      {netdevsim, ETH_ALEN},
      {"xfrm0", ETH_ALEN},
      {"veth0_virt_wifi", ETH_ALEN},
      {"veth1_virt_wifi", ETH_ALEN},
      {"virt_wifi0", ETH_ALEN},
      {"veth0_vlan", ETH_ALEN},
      {"veth1_vlan", ETH_ALEN},
      {"vlan0", ETH_ALEN},
      {"vlan1", ETH_ALEN},
      {"macvlan0", ETH_ALEN},
      {"macvlan1", ETH_ALEN},
      {"ipvlan0", ETH_ALEN},
      {"ipvlan1", ETH_ALEN},
      {"veth0_macvtap", ETH_ALEN},
      {"veth1_macvtap", ETH_ALEN},
      {"macvtap0", ETH_ALEN},
      {"macsec0", ETH_ALEN},
      {"veth0_to_batadv", ETH_ALEN},
      {"veth1_to_batadv", ETH_ALEN},
      {"batadv_slave_0", ETH_ALEN},
      {"batadv_slave_1", ETH_ALEN},
      {"geneve0", ETH_ALEN},
      {"geneve1", ETH_ALEN},
      {"wg0", 0},
      {"wg1", 0},
      {"wg2", 0},
  };
  int sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
  if (sock == -1) exit(1);
  unsigned i;
  for (i = 0; i < sizeof(devtypes) / sizeof(devtypes[0]); i++)
    netlink_add_device(&nlmsg, sock, devtypes[i].type, devtypes[i].dev);
  for (i = 0; i < sizeof(devmasters) / (sizeof(devmasters[0])); i++) {
    char master[32], slave0[32], veth0[32], slave1[32], veth1[32];
    sprintf(slave0, "%s_slave_0", devmasters[i]);
    sprintf(veth0, "veth0_to_%s", devmasters[i]);
    netlink_add_veth(&nlmsg, sock, slave0, veth0);
    sprintf(slave1, "%s_slave_1", devmasters[i]);
    sprintf(veth1, "veth1_to_%s", devmasters[i]);
    netlink_add_veth(&nlmsg, sock, slave1, veth1);
    sprintf(master, "%s0", devmasters[i]);
    netlink_device_change(&nlmsg, sock, slave0, false, master, 0, 0, NULL);
    netlink_device_change(&nlmsg, sock, slave1, false, master, 0, 0, NULL);
  }
  netlink_add_xfrm(&nlmsg, sock, "xfrm0");
  netlink_device_change(&nlmsg, sock, "bridge_slave_0", true, 0, 0, 0, NULL);
  netlink_device_change(&nlmsg, sock, "bridge_slave_1", true, 0, 0, 0, NULL);
  netlink_add_veth(&nlmsg, sock, "hsr_slave_0", "veth0_to_hsr");
  netlink_add_veth(&nlmsg, sock, "hsr_slave_1", "veth1_to_hsr");
  netlink_add_hsr(&nlmsg, sock, "hsr0", "hsr_slave_0", "hsr_slave_1");
  netlink_device_change(&nlmsg, sock, "hsr_slave_0", true, 0, 0, 0, NULL);
  netlink_device_change(&nlmsg, sock, "hsr_slave_1", true, 0, 0, 0, NULL);
  netlink_add_veth(&nlmsg, sock, "veth0_virt_wifi", "veth1_virt_wifi");
  netlink_add_linked(&nlmsg, sock, "virt_wifi", "virt_wifi0",
                     "veth1_virt_wifi");
  netlink_add_veth(&nlmsg, sock, "veth0_vlan", "veth1_vlan");
  netlink_add_vlan(&nlmsg, sock, "vlan0", "veth0_vlan", 0, htons(ETH_P_8021Q));
  netlink_add_vlan(&nlmsg, sock, "vlan1", "veth0_vlan", 1, htons(ETH_P_8021AD));
  netlink_add_macvlan(&nlmsg, sock, "macvlan0", "veth1_vlan");
  netlink_add_macvlan(&nlmsg, sock, "macvlan1", "veth1_vlan");
  netlink_add_ipvlan(&nlmsg, sock, "ipvlan0", "veth0_vlan", IPVLAN_MODE_L2, 0);
  netlink_add_ipvlan(&nlmsg, sock, "ipvlan1", "veth0_vlan", IPVLAN_MODE_L3S,
                     IPVLAN_F_VEPA);
  netlink_add_veth(&nlmsg, sock, "veth0_macvtap", "veth1_macvtap");
  netlink_add_linked(&nlmsg, sock, "macvtap", "macvtap0", "veth0_macvtap");
  netlink_add_linked(&nlmsg, sock, "macsec", "macsec0", "veth1_macvtap");
  char addr[32];
  sprintf(addr, DEV_IPV4, 14 + 10);
  struct in_addr geneve_addr4;
  if (inet_pton(AF_INET, addr, &geneve_addr4) <= 0) exit(1);
  struct in6_addr geneve_addr6;
  if (inet_pton(AF_INET6, "fc00::01", &geneve_addr6) <= 0) exit(1);
  netlink_add_geneve(&nlmsg, sock, "geneve0", 0, &geneve_addr4, 0);
  netlink_add_geneve(&nlmsg, sock, "geneve1", 1, 0, &geneve_addr6);
  netdevsim_add((int)procid, 4);
  netlink_wireguard_setup();
  for (i = 0; i < sizeof(devices) / (sizeof(devices[0])); i++) {
    char addr[32];
    sprintf(addr, DEV_IPV4, i + 10);
    netlink_add_addr4(&nlmsg, sock, devices[i].name, addr);
    if (!devices[i].noipv6) {
      sprintf(addr, DEV_IPV6, i + 10);
      netlink_add_addr6(&nlmsg, sock, devices[i].name, addr);
    }
    uint64_t macaddr = DEV_MAC + ((i + 10ull) << 40);
    netlink_device_change(&nlmsg, sock, devices[i].name, true, 0, &macaddr,
                          devices[i].macsize, NULL);
  }
  close(sock);
}
static void initialize_netdevices_init(void) {
  int sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
  if (sock == -1) exit(1);
  struct {
    const char* type;
    int macsize;
    bool noipv6;
    bool noup;
  } devtypes[] = {
      {"nr", 7, true},
      {"rose", 5, true, true},
  };
  unsigned i;
  for (i = 0; i < sizeof(devtypes) / sizeof(devtypes[0]); i++) {
    char dev[32], addr[32];
    sprintf(dev, "%s%d", devtypes[i].type, (int)procid);
    sprintf(addr, "172.30.%d.%d", i, (int)procid + 1);
    netlink_add_addr4(&nlmsg, sock, dev, addr);
    if (!devtypes[i].noipv6) {
      sprintf(addr, "fe88::%02x:%02x", i, (int)procid + 1);
      netlink_add_addr6(&nlmsg, sock, dev, addr);
    }
    int macsize = devtypes[i].macsize;
    uint64_t macaddr = 0xbbbbbb +
                       ((unsigned long long)i << (8 * (macsize - 2))) +
                       (procid << (8 * (macsize - 1)));
    netlink_device_change(&nlmsg, sock, dev, !devtypes[i].noup, 0, &macaddr,
                          macsize, NULL);
  }
  close(sock);
}

#define MAX_FDS 30

#define USB_MAX_IFACE_NUM 4
#define USB_MAX_EP_NUM 32
#define USB_MAX_FDS 6

struct usb_endpoint_index {
  struct usb_endpoint_descriptor desc;
  int handle;
};

struct usb_iface_index {
  struct usb_interface_descriptor* iface;
  uint8_t bInterfaceNumber;
  uint8_t bAlternateSetting;
  uint8_t bInterfaceClass;
  struct usb_endpoint_index eps[USB_MAX_EP_NUM];
  int eps_num;
};

struct usb_device_index {
  struct usb_device_descriptor* dev;
  struct usb_config_descriptor* config;
  uint8_t bDeviceClass;
  uint8_t bMaxPower;
  int config_length;
  struct usb_iface_index ifaces[USB_MAX_IFACE_NUM];
  int ifaces_num;
  int iface_cur;
};

struct usb_info {
  int fd;
  struct usb_device_index index;
};

static struct usb_info usb_devices[USB_MAX_FDS];

static struct usb_device_index* lookup_usb_index(int fd) {
  for (int i = 0; i < USB_MAX_FDS; i++) {
    if (__atomic_load_n(&usb_devices[i].fd, __ATOMIC_ACQUIRE) == fd)
      return &usb_devices[i].index;
  }
  return NULL;
}

struct vusb_connect_string_descriptor {
  uint32_t len;
  char* str;
} __attribute__((packed));

struct vusb_connect_descriptors {
  uint32_t qual_len;
  char* qual;
  uint32_t bos_len;
  char* bos;
  uint32_t strs_len;
  struct vusb_connect_string_descriptor strs[0];
} __attribute__((packed));

typedef bool (*lookup_connect_out_response_t)(
    int fd, const struct vusb_connect_descriptors* descs,
    const struct usb_ctrlrequest* ctrl, bool* done);

struct vusb_descriptor {
  uint8_t req_type;
  uint8_t desc_type;
  uint32_t len;
  char data[0];
} __attribute__((packed));

struct vusb_descriptors {
  uint32_t len;
  struct vusb_descriptor* generic;
  struct vusb_descriptor* descs[0];
} __attribute__((packed));

struct vusb_response {
  uint8_t type;
  uint8_t req;
  uint32_t len;
  char data[0];
} __attribute__((packed));

struct vusb_responses {
  uint32_t len;
  struct vusb_response* generic;
  struct vusb_response* resps[0];
} __attribute__((packed));

static bool lookup_control_response(const struct vusb_descriptors* descs,
                                    const struct vusb_responses* resps,
                                    struct usb_ctrlrequest* ctrl,
                                    char** response_data,
                                    uint32_t* response_length) {
  int descs_num = 0;
  int resps_num = 0;
  if (descs)
    descs_num = (descs->len - offsetof(struct vusb_descriptors, descs)) /
                sizeof(descs->descs[0]);
  if (resps)
    resps_num = (resps->len - offsetof(struct vusb_responses, resps)) /
                sizeof(resps->resps[0]);
  uint8_t req = ctrl->bRequest;
  uint8_t req_type = ctrl->bRequestType & USB_TYPE_MASK;
  uint8_t desc_type = ctrl->wValue >> 8;
  if (req == USB_REQ_GET_DESCRIPTOR) {
    int i;
    for (i = 0; i < descs_num; i++) {
      struct vusb_descriptor* desc = descs->descs[i];
      if (!desc) continue;
      if (desc->req_type == req_type && desc->desc_type == desc_type) {
        *response_length = desc->len;
        if (*response_length != 0)
          *response_data = &desc->data[0];
        else
          *response_data = NULL;
        return true;
      }
    }
    if (descs && descs->generic) {
      *response_data = &descs->generic->data[0];
      *response_length = descs->generic->len;
      return true;
    }
  } else {
    int i;
    for (i = 0; i < resps_num; i++) {
      struct vusb_response* resp = resps->resps[i];
      if (!resp) continue;
      if (resp->type == req_type && resp->req == req) {
        *response_length = resp->len;
        if (*response_length != 0)
          *response_data = &resp->data[0];
        else
          *response_data = NULL;
        return true;
      }
    }
    if (resps && resps->generic) {
      *response_data = &resps->generic->data[0];
      *response_length = resps->generic->len;
      return true;
    }
  }
  return false;
}

#define UDC_NAME_LENGTH_MAX 128

struct usb_raw_init {
  __u8 driver_name[UDC_NAME_LENGTH_MAX];
  __u8 device_name[UDC_NAME_LENGTH_MAX];
  __u8 speed;
};

enum usb_raw_event_type {
  USB_RAW_EVENT_INVALID = 0,
  USB_RAW_EVENT_CONNECT = 1,
  USB_RAW_EVENT_CONTROL = 2,
};

struct usb_raw_event {
  __u32 type;
  __u32 length;
  __u8 data[0];
};

struct usb_raw_ep_io {
  __u16 ep;
  __u16 flags;
  __u32 length;
  __u8 data[0];
};

#define USB_RAW_EPS_NUM_MAX 30
#define USB_RAW_EP_NAME_MAX 16
#define USB_RAW_EP_ADDR_ANY 0xff

struct usb_raw_ep_caps {
  __u32 type_control : 1;
  __u32 type_iso : 1;
  __u32 type_bulk : 1;
  __u32 type_int : 1;
  __u32 dir_in : 1;
  __u32 dir_out : 1;
};

struct usb_raw_ep_limits {
  __u16 maxpacket_limit;
  __u16 max_streams;
  __u32 reserved;
};

struct usb_raw_ep_info {
  __u8 name[USB_RAW_EP_NAME_MAX];
  __u32 addr;
  struct usb_raw_ep_caps caps;
  struct usb_raw_ep_limits limits;
};

struct usb_raw_eps_info {
  struct usb_raw_ep_info eps[USB_RAW_EPS_NUM_MAX];
};

#define USB_RAW_IOCTL_INIT _IOW('U', 0, struct usb_raw_init)
#define USB_RAW_IOCTL_RUN _IO('U', 1)
#define USB_RAW_IOCTL_EVENT_FETCH _IOR('U', 2, struct usb_raw_event)
#define USB_RAW_IOCTL_EP0_WRITE _IOW('U', 3, struct usb_raw_ep_io)
#define USB_RAW_IOCTL_EP0_READ _IOWR('U', 4, struct usb_raw_ep_io)
#define USB_RAW_IOCTL_EP_ENABLE _IOW('U', 5, struct usb_endpoint_descriptor)
#define USB_RAW_IOCTL_EP_DISABLE _IOW('U', 6, __u32)
#define USB_RAW_IOCTL_EP_WRITE _IOW('U', 7, struct usb_raw_ep_io)
#define USB_RAW_IOCTL_EP_READ _IOWR('U', 8, struct usb_raw_ep_io)
#define USB_RAW_IOCTL_CONFIGURE _IO('U', 9)
#define USB_RAW_IOCTL_VBUS_DRAW _IOW('U', 10, __u32)
#define USB_RAW_IOCTL_EPS_INFO _IOR('U', 11, struct usb_raw_eps_info)
#define USB_RAW_IOCTL_EP0_STALL _IO('U', 12)
#define USB_RAW_IOCTL_EP_SET_HALT _IOW('U', 13, __u32)
#define USB_RAW_IOCTL_EP_CLEAR_HALT _IOW('U', 14, __u32)
#define USB_RAW_IOCTL_EP_SET_WEDGE _IOW('U', 15, __u32)

static int usb_raw_ep_write(int fd, struct usb_raw_ep_io* io) {
  return ioctl(fd, USB_RAW_IOCTL_EP_WRITE, io);
}

static int usb_raw_ep0_write(int fd, struct usb_raw_ep_io* io) {
  return ioctl(fd, USB_RAW_IOCTL_EP0_WRITE, io);
}

static int usb_raw_ep0_read(int fd, struct usb_raw_ep_io* io) {
  return ioctl(fd, USB_RAW_IOCTL_EP0_READ, io);
}

static int usb_raw_event_fetch(int fd, struct usb_raw_event* event) {
  return ioctl(fd, USB_RAW_IOCTL_EVENT_FETCH, event);
}

static int usb_raw_ep_enable(int fd, struct usb_endpoint_descriptor* desc) {
  return ioctl(fd, USB_RAW_IOCTL_EP_ENABLE, desc);
}

static int usb_raw_ep_disable(int fd, int ep) {
  return ioctl(fd, USB_RAW_IOCTL_EP_DISABLE, ep);
}

static int usb_raw_ep0_stall(int fd) {
  return ioctl(fd, USB_RAW_IOCTL_EP0_STALL, 0);
}

static int lookup_interface(int fd, uint8_t bInterfaceNumber,
                            uint8_t bAlternateSetting) {
  struct usb_device_index* index = lookup_usb_index(fd);
  if (!index) return -1;
  for (int i = 0; i < index->ifaces_num; i++) {
    if (index->ifaces[i].bInterfaceNumber == bInterfaceNumber &&
        index->ifaces[i].bAlternateSetting == bAlternateSetting)
      return i;
  }
  return -1;
}

static int lookup_endpoint(int fd, uint8_t bEndpointAddress) {
  struct usb_device_index* index = lookup_usb_index(fd);
  if (!index) return -1;
  if (index->iface_cur < 0) return -1;
  for (int ep = 0; ep < index->ifaces[index->iface_cur].eps_num; ep++)
    if (index->ifaces[index->iface_cur].eps[ep].desc.bEndpointAddress ==
        bEndpointAddress)
      return index->ifaces[index->iface_cur].eps[ep].handle;
  return -1;
}

#define USB_MAX_PACKET_SIZE 4096

struct usb_raw_control_event {
  struct usb_raw_event inner;
  struct usb_ctrlrequest ctrl;
  char data[USB_MAX_PACKET_SIZE];
};

struct usb_raw_ep_io_data {
  struct usb_raw_ep_io inner;
  char data[USB_MAX_PACKET_SIZE];
};

static void set_interface(int fd, int n) {
  struct usb_device_index* index = lookup_usb_index(fd);
  if (!index) return;
  if (index->iface_cur >= 0 && index->iface_cur < index->ifaces_num) {
    for (int ep = 0; ep < index->ifaces[index->iface_cur].eps_num; ep++) {
      int rv = usb_raw_ep_disable(
          fd, index->ifaces[index->iface_cur].eps[ep].handle);
      if (rv < 0) {
      } else {
      }
    }
  }
  if (n >= 0 && n < index->ifaces_num) {
    for (int ep = 0; ep < index->ifaces[n].eps_num; ep++) {
      int rv = usb_raw_ep_enable(fd, &index->ifaces[n].eps[ep].desc);
      if (rv < 0) {
      } else {
        index->ifaces[n].eps[ep].handle = rv;
      }
    }
    index->iface_cur = n;
  }
}

static volatile long syz_usb_control_io(volatile long a0, volatile long a1,
                                        volatile long a2) {
  int fd = a0;
  const struct vusb_descriptors* descs = (const struct vusb_descriptors*)a1;
  const struct vusb_responses* resps = (const struct vusb_responses*)a2;
  struct usb_raw_control_event event;
  event.inner.type = 0;
  event.inner.length = USB_MAX_PACKET_SIZE;
  int rv = usb_raw_event_fetch(fd, (struct usb_raw_event*)&event);
  if (rv < 0) {
    return rv;
  }
  if (event.inner.type != USB_RAW_EVENT_CONTROL) {
    return -1;
  }
  char* response_data = NULL;
  uint32_t response_length = 0;
  if ((event.ctrl.bRequestType & USB_DIR_IN) && event.ctrl.wLength) {
    if (!lookup_control_response(descs, resps, &event.ctrl, &response_data,
                                 &response_length)) {
      usb_raw_ep0_stall(fd);
      return -1;
    }
  } else {
    if ((event.ctrl.bRequestType & USB_TYPE_MASK) == USB_TYPE_STANDARD ||
        event.ctrl.bRequest == USB_REQ_SET_INTERFACE) {
      int iface_num = event.ctrl.wIndex;
      int alt_set = event.ctrl.wValue;
      int iface_index = lookup_interface(fd, iface_num, alt_set);
      if (iface_index < 0) {
      } else {
        set_interface(fd, iface_index);
      }
    }
    response_length = event.ctrl.wLength;
  }
  struct usb_raw_ep_io_data response;
  response.inner.ep = 0;
  response.inner.flags = 0;
  if (response_length > sizeof(response.data)) response_length = 0;
  if (event.ctrl.wLength < response_length)
    response_length = event.ctrl.wLength;
  if ((event.ctrl.bRequestType & USB_DIR_IN) && !event.ctrl.wLength) {
    response_length = USB_MAX_PACKET_SIZE;
  }
  response.inner.length = response_length;
  if (response_data)
    memcpy(&response.data[0], response_data, response_length);
  else
    memset(&response.data[0], 0, response_length);
  if ((event.ctrl.bRequestType & USB_DIR_IN) && event.ctrl.wLength) {
    rv = usb_raw_ep0_write(fd, (struct usb_raw_ep_io*)&response);
  } else {
    rv = usb_raw_ep0_read(fd, (struct usb_raw_ep_io*)&response);
  }
  if (rv < 0) {
    return rv;
  }
  sleep_ms(200);
  return 0;
}

static volatile long syz_usb_ep_write(volatile long a0, volatile long a1,
                                      volatile long a2, volatile long a3) {
  int fd = a0;
  uint8_t ep = a1;
  uint32_t len = a2;
  char* data = (char*)a3;
  int ep_handle = lookup_endpoint(fd, ep);
  if (ep_handle < 0) {
    return -1;
  }
  struct usb_raw_ep_io_data io_data;
  io_data.inner.ep = ep_handle;
  io_data.inner.flags = 0;
  if (len > sizeof(io_data.data)) len = sizeof(io_data.data);
  io_data.inner.length = len;
  memcpy(&io_data.data[0], data, len);
  int rv = usb_raw_ep_write(fd, (struct usb_raw_ep_io*)&io_data);
  if (rv < 0) {
    return rv;
  }
  sleep_ms(200);
  return 0;
}

static void setup_common() {
  if (mount(0, "/sys/fs/fuse/connections", "fusectl", 0, 0)) {
  }
}

static void setup_binderfs() {
  if (mkdir("/dev/binderfs", 0777)) {
  }
  if (mount("binder", "/dev/binderfs", "binder", 0, NULL)) {
  }
  if (symlink("/dev/binderfs", "./binderfs")) {
  }
}

static void loop();

static void sandbox_common() {
  prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
  setsid();
  struct rlimit rlim;
  rlim.rlim_cur = rlim.rlim_max = (200 << 20);
  setrlimit(RLIMIT_AS, &rlim);
  rlim.rlim_cur = rlim.rlim_max = 32 << 20;
  setrlimit(RLIMIT_MEMLOCK, &rlim);
  rlim.rlim_cur = rlim.rlim_max = 136 << 20;
  setrlimit(RLIMIT_FSIZE, &rlim);
  rlim.rlim_cur = rlim.rlim_max = 1 << 20;
  setrlimit(RLIMIT_STACK, &rlim);
  rlim.rlim_cur = rlim.rlim_max = 128 << 20;
  setrlimit(RLIMIT_CORE, &rlim);
  rlim.rlim_cur = rlim.rlim_max = 256;
  setrlimit(RLIMIT_NOFILE, &rlim);
  if (unshare(CLONE_NEWNS)) {
  }
  if (mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL)) {
  }
  if (unshare(CLONE_NEWIPC)) {
  }
  if (unshare(0x02000000)) {
  }
  if (unshare(CLONE_NEWUTS)) {
  }
  if (unshare(CLONE_SYSVSEM)) {
  }
  typedef struct {
    const char* name;
    const char* value;
  } sysctl_t;
  static const sysctl_t sysctls[] = {
      {"/proc/sys/kernel/shmmax", "16777216"},
      {"/proc/sys/kernel/shmall", "536870912"},
      {"/proc/sys/kernel/shmmni", "1024"},
      {"/proc/sys/kernel/msgmax", "8192"},
      {"/proc/sys/kernel/msgmni", "1024"},
      {"/proc/sys/kernel/msgmnb", "1024"},
      {"/proc/sys/kernel/sem", "1024 1048576 500 1024"},
  };
  unsigned i;
  for (i = 0; i < sizeof(sysctls) / sizeof(sysctls[0]); i++)
    write_file(sysctls[i].name, sysctls[i].value);
}

static int wait_for_loop(int pid) {
  if (pid < 0) exit(1);
  int status = 0;
  while (waitpid(-1, &status, __WALL) != pid) {
  }
  return WEXITSTATUS(status);
}

static void drop_caps(void) {
  struct __user_cap_header_struct cap_hdr = {};
  struct __user_cap_data_struct cap_data[2] = {};
  cap_hdr.version = _LINUX_CAPABILITY_VERSION_3;
  cap_hdr.pid = getpid();
  if (syscall(SYS_capget, &cap_hdr, &cap_data)) exit(1);
  const int drop = (1 << CAP_SYS_PTRACE) | (1 << CAP_SYS_NICE);
  cap_data[0].effective &= ~drop;
  cap_data[0].permitted &= ~drop;
  cap_data[0].inheritable &= ~drop;
  if (syscall(SYS_capset, &cap_hdr, &cap_data)) exit(1);
}

static int do_sandbox_none(void) {
  if (unshare(CLONE_NEWPID)) {
  }
  int pid = fork();
  if (pid != 0) return wait_for_loop(pid);
  setup_common();
  sandbox_common();
  drop_caps();
  initialize_netdevices_init();
  if (unshare(CLONE_NEWNET)) {
  }
  write_file("/proc/sys/net/ipv4/ping_group_range", "0 65535");
  initialize_netdevices();
  setup_binderfs();
  loop();
  exit(1);
}

static void kill_and_wait(int pid, int* status) {
  kill(-pid, SIGKILL);
  kill(pid, SIGKILL);
  for (int i = 0; i < 100; i++) {
    if (waitpid(-1, status, WNOHANG | __WALL) == pid) return;
    usleep(1000);
  }
  DIR* dir = opendir("/sys/fs/fuse/connections");
  if (dir) {
    for (;;) {
      struct dirent* ent = readdir(dir);
      if (!ent) break;
      if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
        continue;
      char abort[300];
      snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
               ent->d_name);
      int fd = open(abort, O_WRONLY);
      if (fd == -1) {
        continue;
      }
      if (write(fd, abort, 1) < 0) {
      }
      close(fd);
    }
    closedir(dir);
  } else {
  }
  while (waitpid(-1, status, __WALL) != pid) {
  }
}

static void setup_test() {
  prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
  setpgrp();
  write_file("/proc/self/oom_score_adj", "1000");
}

static void close_fds() {
  for (int fd = 3; fd < MAX_FDS; fd++) close(fd);
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void) {
  int iter = 0;
  for (;; iter++) {
    int pid = fork();
    if (pid < 0) exit(1);
    if (pid == 0) {
      setup_test();
      execute_one();
      close_fds();
      exit(0);
    }
    int status = 0;
    uint64_t start = current_time_ms();
    for (;;) {
      if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid) break;
      sleep_ms(1);
      if (current_time_ms() - start < 5000) continue;
      kill_and_wait(pid, &status);
      break;
    }
  }
}

uint64_t r[7] = {0xffffffffffffffff, 0x0, 0xffffffffffffffff, 0x0,
                 0xffffffffffffffff, 0x0, 0xffffffffffffffff};

void execute_one(void) {
  intptr_t res = 0;
  syz_usb_control_io(/*fd=*/-1, /*descs=*/0, /*resps=*/0);
  syz_usb_control_io(/*fd=*/-1, /*descs=*/0, /*resps=*/0);
  syz_usb_control_io(/*fd=*/-1, /*descs=*/0, /*resps=*/0);
  syz_usb_control_io(/*fd=*/-1, /*descs=*/0, /*resps=*/0);
  syz_usb_ep_write(/*fd=*/-1, /*ep=*/0x82, /*len=*/0, /*data=*/0);
  syz_usb_control_io(/*fd=*/-1, /*descs=*/0, /*resps=*/0);
  res = syscall(__NR_socket, /*domain=*/0x10ul, /*type=*/3ul, /*proto=*/0);
  if (res != -1) r[0] = res;
  memcpy((void*)0x20001800, "vxcan0\000\000\000\000\000\000\000\000\000\000",
         16);
  res = syscall(__NR_ioctl, /*fd=*/r[0], /*cmd=*/0x8933, /*arg=*/0x20001800ul);
  if (res != -1) r[1] = *(uint32_t*)0x20001810;
  res = syscall(__NR_socket, /*domain=*/0xaul, /*type=*/1ul, /*proto=*/0);
  if (res != -1) r[2] = res;
  memcpy((void*)0x20000340, "vxcan1\000\000\000\000\000\000\000\000\000\000",
         16);
  res = syscall(__NR_ioctl, /*fd=*/r[2], /*cmd=*/0x8933, /*arg=*/0x20000340ul);
  if (res != -1) r[3] = *(uint32_t*)0x20000350;
  *(uint64_t*)0x20000180 = 0;
  *(uint32_t*)0x20000188 = 0;
  *(uint64_t*)0x20000190 = 0x20000140;
  *(uint64_t*)0x20000140 = 0x200003c0;
  *(uint32_t*)0x200003c0 = 0x24;
  *(uint16_t*)0x200003c4 = 0x18;
  *(uint16_t*)0x200003c6 = 1;
  *(uint32_t*)0x200003c8 = 0;
  *(uint32_t*)0x200003cc = 0;
  *(uint8_t*)0x200003d0 = 0x1d;
  *(uint8_t*)0x200003d1 = 1;
  *(uint16_t*)0x200003d2 = 0;
  *(uint16_t*)0x200003d4 = 8;
  *(uint16_t*)0x200003d6 = 9;
  *(uint32_t*)0x200003d8 = r[1];
  *(uint16_t*)0x200003dc = 8;
  *(uint16_t*)0x200003de = 0xa;
  *(uint32_t*)0x200003e0 = r[3];
  *(uint64_t*)0x20000148 = 0x24;
  *(uint64_t*)0x20000198 = 1;
  *(uint64_t*)0x200001a0 = 4;
  *(uint64_t*)0x200001a8 = 0;
  *(uint32_t*)0x200001b0 = 0;
  syscall(__NR_sendmsg, /*fd=*/r[0], /*msg=*/0x20000180ul, /*f=*/0ul);
  syscall(__NR_sendmsg, /*fd=*/-1, /*msg=*/0ul, /*f=*/0x4000ul);
  syscall(__NR_socket, /*domain=*/0xaul, /*type=*/1ul, /*proto=*/0);
  syscall(__NR_bpf, /*cmd=*/5ul, /*arg=*/0ul, /*size=*/0ul);
  syscall(__NR_bpf, /*cmd=*/0xdul, /*arg=*/0ul, /*size=*/0ul);
  syscall(__NR_setsockopt, /*fd=*/-1, /*level=*/1, /*optname=*/0x32,
          /*optval=*/0ul, /*optlen=*/0ul);
  syscall(__NR_getsockname, /*fd=*/-1, /*addr=*/0ul, /*addrlen=*/0ul);
  syscall(__NR_openat, /*fd=*/0xffffff9c, /*file=*/0ul,
          /*flags=*/0xb00000000065808ul, /*mode=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0xb36000ul, /*prot=*/2ul,
          /*flags=*/0x28011ul, /*fd=*/-1, /*offset=*/0ul);
  syscall(__NR_bpf, /*cmd=*/0ul, /*arg=*/0ul, /*size=*/0ul);
  syscall(__NR_bpf, /*cmd=*/5ul, /*arg=*/0ul, /*size=*/0ul);
  syscall(__NR_write, /*fd=*/-1, /*data=*/0ul, /*len=*/0x208e24bul);
  res = syscall(__NR_socket, /*domain=*/0x1dul, /*type=*/2ul, /*proto=*/7);
  if (res != -1) r[4] = res;
  memcpy((void*)0x20000000, "vxcan0\000\000\000\000\000\000\000\000\000\000",
         16);
  res = syscall(__NR_ioctl, /*fd=*/r[4], /*cmd=*/0x8933, /*arg=*/0x20000000ul);
  if (res != -1) r[5] = *(uint32_t*)0x20000010;
  *(uint16_t*)0x20000240 = 0x1d;
  *(uint32_t*)0x20000244 = r[5];
  *(uint64_t*)0x20000248 = 0;
  *(uint8_t*)0x20000250 = 0;
  *(uint8_t*)0x20000251 = 0;
  *(uint8_t*)0x20000252 = 0;
  *(uint8_t*)0x20000253 = 0;
  *(uint8_t*)0x20000254 = 0;
  syscall(__NR_bind, /*fd=*/r[4], /*addr=*/0x20000240ul, /*len=*/0x18ul);
  *(uint16_t*)0x20000080 = 0x1d;
  *(uint32_t*)0x20000084 = r[5];
  *(uint64_t*)0x20000088 = 0;
  *(uint8_t*)0x20000090 = 0;
  *(uint8_t*)0x20000091 = 0;
  *(uint8_t*)0x20000092 = 0;
  *(uint8_t*)0x20000093 = 0;
  *(uint8_t*)0x20000094 = 0;
  syscall(__NR_connect, /*fd=*/r[4], /*addr=*/0x20000080ul, /*len=*/0x18ul);
  *(uint64_t*)0x200038c0 = 0x20000280;
  *(uint16_t*)0x20000280 = 0x1d;
  *(uint32_t*)0x20000284 = 0;
  *(uint32_t*)0x20000288 = 0;
  *(uint32_t*)0x2000028c = 0;
  *(uint32_t*)0x200038c8 = 0x80;
  *(uint64_t*)0x200038d0 = 0;
  *(uint64_t*)0x200038d8 = 0;
  *(uint64_t*)0x200038e0 = 0;
  *(uint64_t*)0x200038e8 = 0;
  *(uint32_t*)0x200038f0 = 0;
  *(uint32_t*)0x200038f8 = 0;
  *(uint64_t*)0x20003900 = 0;
  *(uint32_t*)0x20003908 = 0;
  *(uint64_t*)0x20003910 = 0x20001980;
  *(uint64_t*)0x20001980 = 0x20001640;
  memset((void*)0x20001640, 3, 1);
  *(uint64_t*)0x20001988 = 0x1a000;
  *(uint64_t*)0x20003918 = 1;
  *(uint64_t*)0x20003920 = 0;
  *(uint64_t*)0x20003928 = 0;
  *(uint32_t*)0x20003930 = 0;
  *(uint32_t*)0x20003938 = 0;
  syscall(__NR_sendmmsg, /*fd=*/r[4], /*mmsg=*/0x200038c0ul, /*vlen=*/2ul,
          /*f=*/0ul);
  res = syscall(__NR_socket, /*domain=*/0x1dul, /*type=*/2ul, /*proto=*/7);
  if (res != -1) r[6] = res;
  syscall(__NR_connect, /*fd=*/r[6], /*addr=*/0ul, /*len=*/0ul);
}
int main(void) {
  syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul, /*prot=*/7ul,
          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
  do_sandbox_none();
  return 0;
}

see also https://gist.github.com/xrivendell7/c8b98b4b628f115291e90971369d5b6b
I confirmed the repo.can really trigger the kernel crash but maybe not
titled "WARNING in j1939_xtp_rx_rts".
BTW, I test your patch in the kernel commit 1c41041124bd with patch your provide

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index fe3df23a2595..21ba166aed8f 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1593,8 +1593,8 @@ j1939_session
*j1939_xtp_rx_rts_session_new(struct j1939_priv *priv,
        struct j1939_sk_buff_cb skcb = *j1939_skb_to_cb(skb);
        struct j1939_session *session;
        const u8 *dat;
+       int len, ret;
        pgn_t pgn;
-       int len;

        netdev_dbg(priv->ndev, "%s\n", __func__);

@@ -1654,6 +1654,22 @@ j1939_session
*j1939_xtp_rx_rts_session_new(struct j1939_priv *priv,
        j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_RTS);

        WARN_ON_ONCE(j1939_session_activate(session));
+       ret = j1939_session_activate(session);
+       if (ret) {
+       /* Entering this scope indicates an issue with the J1939 bus.
+               * Possible scenarios include:
+               * - A time lapse occurred, and a new session was initiated
+               *   due to another packet being sent correctly. This could
+               *   have been caused by too long interrupt, debugger, or being
+               *   out-scheduled by another task.
+               * - The bus is receiving numerous erroneous packets, either
+               *   from a malfunctioning device or during a test scenario.
+               */
+               netdev_alert(priv->ndev, "%s: 0x%p: concurrent session
with same addr (%02x %02x) is already active.\n",
+                                               __func__, session,
skcb.addr.sa, skcb.addr.da);
+               j1939_session_put(session);
+               return NULL;
+       }

However, it still trigger the crash like below:

[ 3581.874614][    C2]  ? kthread_complete_and_exit+0x40/0x40
[ 3581.876719][    C0] vxcan0: j1939_xtp_rx_rts_session_new:
0xffff88801ca59a00: concurrent session with same ad.
[ 3581.876994][    C1] vxcan0: j1939_xtp_rx_abort_one:
0xffff88801ca59a00: 0x00000: (1) Already in one or more c.
[ 3581.877210][    C2]  ret_from_fork_asm+0x11/0x20
[ 3581.879374][    C0] vxcan0: j1939_xtp_rx_rts_session_new:
0xffff888027250200: concurrent session with same ad.
[ 3581.879432][    C1] vxcan0: j1939_xtp_rx_abort_one:
0xffff888027250200: 0x00000: (1) Already in one or more c.
[ 3581.880150][    C2]  </TASK>
[ 3581.882560][    C0] vxcan0: j1939_xtp_rx_rts_session_new:
0xffff888027250800: concurrent session with same ad.
[ 3581.882687][    C1] vxcan0: j1939_xtp_rx_abort_one:
0xffff888027250800: 0x00000: (1) Already in one or more c.
[ 3581.883237][    C2] Kernel panic - not syncing: kernel: panic_on_warn set ...
[ 3581.883251][    C2] CPU: 2 PID: 8226 Comm: kworker/2:0 Not tainted
6.6.0-14500-g1c41041124bd-dirty #2
[ 3581.883279][    C2] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.16.2-debian-1.16.2-1 04/01/4
[ 3581.883297][    C2] Workqueue: ipv6_addrconf addrconf_dad_work
[ 3581.883325][    C2] Call Trace:
[ 3581.883334][    C2]  <IRQ>
[ 3581.883344][    C2]  dump_stack_lvl+0xd9/0x1b0
[ 3581.883378][    C2]  panic+0x6dc/0x790
[ 3581.883411][    C2]  ? panic_smp_self_stop+0xa0/0xa0
[ 3581.883441][    C2]  ? show_trace_log_lvl+0x363/0x4f0
[ 3581.883488][    C2]  ? check_panic_on_warn+0x1f/0xb0
[ 3581.883523][    C2]  ? j1939_xtp_rx_rts+0x1574/0x18e0
[ 3581.883562][    C2]  check_panic_on_warn+0xab/0xb0
[ 3581.883596][    C2]  __warn+0xf2/0x380
[ 3581.883626][    C2]  ? j1939_xtp_rx_rts+0x1574/0x18e0
[ 3581.883666][    C2]  report_bug+0x3bc/0x580
[ 3581.883702][    C2]  handle_bug+0x3c/0x70
[ 3581.883733][    C2]  exc_invalid_op+0x17/0x40
[ 3581.883765][    C2]  asm_exc_invalid_op+0x1a/0x20
[ 3581.883805][    C2] RIP: 0010:j1939_xtp_rx_rts+0x1574/0x18e0
[ 3581.883844][    C2] Code: 00 48 89 ef e8 ed 4a e6 fa e9 21 ef ff ff
e8 23 9b 0d f8 be 01 00 00 00 48 89 ef e88
[ 3581.883869][    C2] RSP: 0018:ffffc90000a70950 EFLAGS: 00010246
[ 3581.883889][    C2] RAX: 0000000000000000 RBX: ffff88801f707400
RCX: ffffffff897af9af
[ 3581.883907][    C2] RDX: ffff888020c98040 RSI: ffffffff897b0174
RDI: 0000000000000005
[ 3581.883924][    C2] RBP: 00000000fffffff5 R08: 0000000000000005
R09: 0000000000000000
[ 3581.883939][    C2] R10: 00000000fffffff5 R11: 0000000000000000
R12: ffff888078052000
[ 3581.883956][    C2] R13: 0000000000003b6e R14: 0000000000000001
R15: ffff88801f7074dc
[ 3581.883983][    C2]  ? j1939_xtp_rx_rts+0xdaf/0x18e0
[ 3581.884020][    C2]  ? j1939_xtp_rx_rts+0x1574/0x18e0
[ 3581.884069][    C2]  ? j1939_ecu_get_by_addr+0x34/0x40
[ 3581.884102][    C2]  ? j1939_session_activate+0x4a0/0x4a0
[ 3581.884151][    C2]  ? __local_bh_enable_ip+0xa4/0x120
[ 3581.884179][    C2]  ? lockdep_hardirqs_on+0x7d/0x100
[ 3581.884215][    C2]  ? j1939_ecu_get_by_addr+0x34/0x40
[ 3581.884246][    C2]  ? __local_bh_enable_ip+0xa4/0x120
[ 3581.884280][    C2]  j1939_tp_recv+0x366/0xf50
[ 3581.884317][    C2]  j1939_can_recv+0x78b/0xa70
[ 3581.884354][    C2]  ? j1939_netdev_notify+0x1d0/0x1d0
[ 3581.884386][    C2]  ? can_can_gw_rcv+0x889/0xab0
[ 3581.884420][    C2]  ? j1939_netdev_notify+0x1d0/0x1d0
[ 3581.884455][    C2]  can_rcv_filter+0x2a5/0x8e0
[ 3581.884489][    C2]  can_receive+0x320/0x5c0
[ 3581.884514][    C2]  ? lockdep_hardirqs_on_prepare+0x410/0x410
[ 3581.884558][    C2]  ? can_receive+0x5c0/0x5c0
[ 3581.884583][    C2]  can_rcv+0x1dc/0x270
[ 3581.884611][    C2]  __netif_receive_skb_one_core+0x115/0x180
[ 3581.884653][    C2]  ? __netif_receive_skb_list_core+0x8a0/0x8a0
[ 3581.884690][    C2]  ? process_backlog+0x131/0x6b0
[ 3581.884726][    C2]  ? reacquire_held_locks+0x4b0/0x4b0
[ 3581.884773][    C2]  __netif_receive_skb+0x1f/0x1b0

